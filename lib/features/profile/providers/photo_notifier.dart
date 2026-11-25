import 'dart:io';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/profile/data/repositories/profile_repository.dart';
import '../../../../utils/api_urls.dart';
import 'profile_notifier.dart';

part 'photo_notifier.g.dart';

@riverpod
class PhotoNotifier extends _$PhotoNotifier {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<bool> uploadPhoto({
    required File file,
    required String photoKey, // "selfie_photo", "photo1", "photo2", "photo3", "photo4"
  }) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        'form_type': 'upload_photos',
        photoKey: await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await repository.postMultipartRequest(editMyProfileApi, formData);
      
      if (response.status == "success") {
        state = const AsyncValue.data(null);
        await ref.read(myProfileProvider.notifier).refresh();
        return true;
      } else {
        state = AsyncValue.error(response.message, StackTrace.current);
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deletePhoto(String photoKey) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      final params = {"photo_key": photoKey};
      final response = await repository.postRequest(removePhotoApi, params);
      
      if (response.status == "success") {
        state = const AsyncValue.data(null);
        await ref.read(myProfileProvider.notifier).refresh();
        return true;
      } else {
        state = AsyncValue.error(response.message, StackTrace.current);
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> uploadHoroscope(File file) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        'form_type': 'upload_horoscope',
        'horoscope_file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await repository.postMultipartRequest(editMyProfileApi, formData);
      
      if (response.status == "success") {
        state = const AsyncValue.data(null);
        await ref.read(myProfileProvider.notifier).refresh();
        return true;
      } else {
        state = AsyncValue.error(response.message, StackTrace.current);
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteHoroscope() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      final response = await repository.getRequest(removeHoroscopeApi);
      
      if (response.status == "success") {
        state = const AsyncValue.data(null);
        await ref.read(myProfileProvider.notifier).refresh();
        return true;
      } else {
        state = AsyncValue.error(response.message, StackTrace.current);
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> uploadIdProof({
    File? frontFile,
    File? backFile,
    required String idProofType, // "Aadhaar", "PAN Card", "Passport", "License"
  }) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      final Map<String, dynamic> fields = {
        'form_type': 'upload_id_proof',
        'id_proof_type': idProofType,
      };
      if (frontFile != null) {
        final fileName = frontFile.path.split('/').last;
        fields['id_proof_front'] = await MultipartFile.fromFile(frontFile.path, filename: fileName);
      }
      if (backFile != null) {
        final fileName = backFile.path.split('/').last;
        fields['id_proof_back'] = await MultipartFile.fromFile(backFile.path, filename: fileName);
      }
      final formData = FormData.fromMap(fields);

      final response = await repository.postMultipartRequest(editMyProfileApi, formData);
      
      if (response.status == "success") {
        state = const AsyncValue.data(null);
        await ref.read(myProfileProvider.notifier).refresh();
        return true;
      } else {
        state = AsyncValue.error(response.message, StackTrace.current);
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> deleteIdProof(String side) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(profileRepositoryProvider);
      final params = {"id_proof_key": side == 'front' ? 'id_proof_front' : 'id_proof_back'};
      final response = await repository.postRequest(removeIdProofApi, params);
      
      if (response.status == "success") {
        state = const AsyncValue.data(null);
        await ref.read(myProfileProvider.notifier).refresh();
        return true;
      } else {
        state = AsyncValue.error(response.message, StackTrace.current);
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}
