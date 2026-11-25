import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/profile/data/repositories/profile_repository.dart';
import 'profile_notifier.dart';

part 'edit_profile_notifier.freezed.dart';
part 'edit_profile_notifier.g.dart';

@freezed
abstract class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    @Default(false) bool isLoading,
    @Default(null) String? errorMessage,
    @Default(null) String? successMessage,
  }) = _EditProfileState;
}

@riverpod
class EditProfileNotifier extends _$EditProfileNotifier {
  @override
  EditProfileState build() {
    return const EditProfileState();
  }

  Future<bool> updateSection(Map<String, dynamic> params) async {
    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);
    try {
      await ref.read(profileRepositoryProvider).updateMyProfile(params);
      state = state.copyWith(isLoading: false, successMessage: "Profile updated successfully");
      // Refresh the main profile data
      await ref.read(myProfileProvider.notifier).refresh();
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}
