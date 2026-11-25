import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../preference/session_keys.dart';
import 'app_session_service.dart';

class FirebaseChatService {
  FirebaseChatService._();
  static final FirebaseChatService instance = FirebaseChatService._();

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  // Track currently active conversation ID (if any)
  String? currentConversationId;
  
  // Track all conversation IDs in the current user's inbox list
  List<String> loadedConversationIds = [];

  /// Updates my chat status in a specific conversation.
  /// status types:
  /// -> 0 = sent (offline)
  /// -> 1 = delivered (online/app open)
  /// -> 2 = seen (in conversation screen)
  Future<void> updateMyChatStatus(String conversationId, int status) async {
    final myUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
    if (myUserId == null) return;

    try {
      final ref = _db.ref('chat_conversations_users/$conversationId/$myUserId/chat_status');
      await ref.set(status);

      // Set up onDisconnect to clean up/set to 0 when disconnected
      await ref.onDisconnect().set(0);
    } catch (e) {
      debugPrint('Error updating my chat status in Firebase: $e');
    }
  }

  /// Bulk updates my chat status across multiple conversation IDs.
  Future<void> updateMyChatStatusBulk(List<String> conversationIds, int status) async {
    final myUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
    if (myUserId == null || conversationIds.isEmpty) return;

    // Track loaded conversation IDs to update them on app open/close
    loadedConversationIds = List.from(conversationIds);

    try {
      final Map<String, dynamic> updates = {};
      for (final convId in conversationIds) {
        // If the user currently has this conversation open, do not downgrade status to 1
        if (currentConversationId != null && convId == currentConversationId) {
          continue;
        }
        updates['chat_conversations_users/$convId/$myUserId/chat_status'] = status;
      }
      if (updates.isNotEmpty) {
        await _db.ref().update(updates);
      }

      // Register onDisconnect for each path
      for (final convId in conversationIds) {
        await _db.ref('chat_conversations_users/$convId/$myUserId/chat_status').onDisconnect().set(0);
      }
    } catch (e) {
      debugPrint('Error in bulk updating my chat status in Firebase: $e');
    }
  }

  /// Ensures that user objects exist in the conversation user status path.
  /// If the conversation object is not created, it initializes it.
  Future<void> ensureConversationObjectsExist(String conversationId, String otherUserId) async {
    final myUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
    if (myUserId == null) return;

    try {
      final ref = _db.ref('chat_conversations_users/$conversationId');
      final snapshot = await ref.get();
      if (!snapshot.exists) {
        await ref.set({
          myUserId: {
            'chat_status': 2, // Entering conversation sets status to 2 (seen)
          },
          otherUserId: {
            'chat_status': 0, // Initialize other user to 0 (offline)
          }
        });
      } else {
        // Just update my status to 2
        await ref.child('$myUserId/chat_status').set(2);
      }
      await _db.ref('chat_conversations_users/$conversationId/$myUserId/chat_status').onDisconnect().set(0);
    } catch (e) {
      debugPrint('Error ensuring conversation objects exist in Firebase: $e');
    }
  }

  /// Streams the other user's chat status.
  Stream<int> streamOtherUserStatus(String conversationId, String otherUserId) {
    return _db
        .ref('chat_conversations_users/$conversationId/$otherUserId/chat_status')
        .onValue
        .map((event) {
          final val = event.snapshot.value;
          if (val == null) return 0;
          return int.tryParse(val.toString()) ?? 0;
        });
  }

  /// Appends last message under `chat_last_message/$receiverId/$conversationId`
  Future<void> updateLastMessage({
    required String receiverId,
    required String conversationId,
    required String messageText,
    required dynamic messageId,
    required String senderId,
  }) async {
    try {
      final ref = _db.ref('chat_last_message/$receiverId/$conversationId');
      
      final msgObject = {
        "conversation_id": conversationId.toString(),
        "message": messageText,
        "message_id": int.tryParse(messageId.toString()) ?? DateTime.now().millisecondsSinceEpoch,
        "receiver_id": receiverId.toString(),
        "sender_id": int.tryParse(senderId.toString()) ?? senderId,
        "time": DateFormat('hh:mm a').format(DateTime.now()),
      };
      
      await ref.set(msgObject);
    } catch (e) {
      debugPrint('Error updating last message in Firebase: $e');
    }
  }

  /// Streams all last messages for a user (to dynamically update the inbox list).
  Stream<Map<String, dynamic>> streamLastMessages(String userId) {
    return _db.ref('chat_last_message/$userId').onValue.map((event) {
      final val = event.snapshot.value;
      if (val == null || val is! Map) return {};
      
      final Map<String, dynamic> result = {};
      val.forEach((k, v) {
        if (v is Map) {
          result[k.toString()] = Map<String, dynamic>.from(v);
        }
      });
      return result;
    });
  }

  /// Streams last message in a specific conversation for the user.
  Stream<Map<String, dynamic>?> streamLastMessageForConversation(String userId, String conversationId) {
    return _db.ref('chat_last_message/$userId/$conversationId').onValue.map((event) {
      final val = event.snapshot.value;
      if (val == null || val is! Map) return null;
      return Map<String, dynamic>.from(val);
    });
  }

  /// Sets presence status when app changes lifecycle state (active/inactive)
  Future<void> setAppOpened(bool open) async {
    final myUserId = AppSessionService.getValue(SessionDetail.kUserId)?.toString();
    if (myUserId == null) return;

    final status = open ? 1 : 0;
    
    try {
      if (currentConversationId != null) {
        // If we are currently on the conversation screen, entering/returning means status is 2 (seen)
        await updateMyChatStatus(currentConversationId!, open ? 2 : 0);
      }
      
      if (loadedConversationIds.isNotEmpty) {
        final Map<String, dynamic> updates = {};
        for (final convId in loadedConversationIds) {
          // If this is the active open conversation, do not overwrite status to 1
          if (currentConversationId != null && convId == currentConversationId) {
            continue;
          }
          updates['chat_conversations_users/$convId/$myUserId/chat_status'] = status;
        }
        if (updates.isNotEmpty) {
          await _db.ref().update(updates);
        }
      }
    } catch (e) {
      debugPrint('Error updating lifecycle presence in Firebase: $e');
    }
  }
}
