import '../features/common/data/models/dropdown_models.dart';
import 'app_debug.dart';

class ApplicationData {
  static ApplicationData? _instance;

  static bool _isFromBackgroundNotification = false;

  static bool? isToOpenPremiumTabScreen = false;
  static bool? isToOpenSuggestedTabScreen = false;
  static bool? isToOpenPhotoRequestSentScreen = false;
  static bool? isConversationScreenIsOpen = false;
  static bool? isManagerChatScreenOpen = false;
  static String? activeConversationId;
  static String? activeReceiverId;
  static bool? isMemberPaid = false;
  static bool? isAllowToVideoCall = false;
  static bool? isAllowToVoiceCall = false;

  static bool? isReceivedViewedProfile = false;

  static String otherMatriId = "";
  static String otherUserId = "";
  static String callType = "";
  static int remainingCallMinutes = 0;
  static bool isCallInitiator = false;

  static DropdownResponseModel? _dropdownResponseModel;

  ApplicationData._internal() {
    printLog("ApplicationData first time init");
    _instance = this;
  }

  factory ApplicationData() => _instance ?? ApplicationData._internal();

  DropdownResponseModel? get getDropdownResponseModel => _dropdownResponseModel;
  set setDropdownResponseModel(DropdownResponseModel? val) => _dropdownResponseModel = val;

  bool get getIsFromBackgroundNotification => _isFromBackgroundNotification;
  set setIsFromBackgroundNotification(bool val) => _isFromBackgroundNotification = val;

}
