class TemplateItem {
  final int id;
  final String templateName;
  final bool selected;

  TemplateItem({
    required this.id,
    required this.templateName,
    required this.selected,
  });

  factory TemplateItem.fromJson(Map<String, dynamic> json) {
    return TemplateItem(
      id: json['id'] as int? ?? 0,
      templateName: (json['template_name'] ?? json['title'])?.toString() ?? "",
      selected: json['selected'] == true ||
          json['selected'] == 1 ||
          json['selected']?.toString() == '1',
    );
  }

  TemplateItem copyWith({
    int? id,
    String? templateName,
    bool? selected,
  }) {
    return TemplateItem(
      id: id ?? this.id,
      templateName: templateName ?? this.templateName,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'template_name': templateName,
      'selected': selected,
    };
  }
}

class PrivacySettingsData {
  final int? photoVisibility;
  final int? contactVisibility;
  final int? videoCallSetting;
  final int? voiceCallSetting;
  final int? interestSentMsgSetting;
  final String? interestSentMessage;
  final int? interestAcceptMsgSetting;
  final String? interestAcceptedMessage;
  final List<TemplateItem> emailTemplates;
  final List<TemplateItem> smsTemplates;
  final List<TemplateItem> notificationTemplates;

  PrivacySettingsData({
    this.photoVisibility,
    this.contactVisibility,
    this.videoCallSetting,
    this.voiceCallSetting,
    this.interestSentMsgSetting,
    this.interestSentMessage,
    this.interestAcceptMsgSetting,
    this.interestAcceptedMessage,
    this.emailTemplates = const [],
    this.smsTemplates = const [],
    this.notificationTemplates = const [],
  });

  factory PrivacySettingsData.fromJson(Map<String, dynamic> json) {
    var emailList = <TemplateItem>[];
    if (json['emailTemplate'] is List) {
      emailList = (json['emailTemplate'] as List)
          .map((e) => TemplateItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    var smsList = <TemplateItem>[];
    if (json['smsTemplate'] is List) {
      smsList = (json['smsTemplate'] as List)
          .map((e) => TemplateItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    var notifList = <TemplateItem>[];
    if (json['notificationTemplates'] is List) {
      notifList = (json['notificationTemplates'] as List)
          .map((e) => TemplateItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return PrivacySettingsData(
      photoVisibility: _parseInt(json['photo_visibility']),
      contactVisibility: _parseInt(json['contact_visibility']),
      videoCallSetting: _parseInt(json['video_call_setting']),
      voiceCallSetting: _parseInt(json['voice_call_setting']),
      interestSentMsgSetting: _parseInt(json['interest_sent_msg_setting']),
      interestSentMessage: json['interest_sent_message']?.toString(),
      interestAcceptMsgSetting: _parseInt(json['interest_accept_msg_setting']),
      interestAcceptedMessage: json['interest_accepted_message']?.toString(),
      emailTemplates: emailList,
      smsTemplates: smsList,
      notificationTemplates: notifList,
    );
  }

  static int? _parseInt(dynamic val) {
    if (val == null) return null;
    if (val is int) return val;
    if (val is String) return int.tryParse(val);
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'photo_visibility': photoVisibility,
      'contact_visibility': contactVisibility,
      'video_call_setting': videoCallSetting,
      'voice_call_setting': voiceCallSetting,
      'interest_sent_msg_setting': interestSentMsgSetting,
      'interest_sent_message': interestSentMessage,
      'interest_accept_msg_setting': interestAcceptMsgSetting,
      'interest_accepted_message': interestAcceptedMessage,
      'emailTemplate': emailTemplates.map((e) => e.toJson()).toList(),
      'smsTemplate': smsTemplates.map((e) => e.toJson()).toList(),
      'notificationTemplates': notificationTemplates.map((e) => e.toJson()).toList(),
    };
  }

  PrivacySettingsData copyWith({
    int? photoVisibility,
    int? contactVisibility,
    int? videoCallSetting,
    int? voiceCallSetting,
    int? interestSentMsgSetting,
    String? interestSentMessage,
    int? interestAcceptMsgSetting,
    String? interestAcceptedMessage,
    List<TemplateItem>? emailTemplates,
    List<TemplateItem>? smsTemplates,
    List<TemplateItem>? notificationTemplates,
  }) {
    return PrivacySettingsData(
      photoVisibility: photoVisibility ?? this.photoVisibility,
      contactVisibility: contactVisibility ?? this.contactVisibility,
      videoCallSetting: videoCallSetting ?? this.videoCallSetting,
      voiceCallSetting: voiceCallSetting ?? this.voiceCallSetting,
      interestSentMsgSetting: interestSentMsgSetting ?? this.interestSentMsgSetting,
      interestSentMessage: interestSentMessage ?? this.interestSentMessage,
      interestAcceptMsgSetting: interestAcceptMsgSetting ?? this.interestAcceptMsgSetting,
      interestAcceptedMessage: interestAcceptedMessage ?? this.interestAcceptedMessage,
      emailTemplates: emailTemplates ?? this.emailTemplates,
      smsTemplates: smsTemplates ?? this.smsTemplates,
      notificationTemplates: notificationTemplates ?? this.notificationTemplates,
    );
  }
}
