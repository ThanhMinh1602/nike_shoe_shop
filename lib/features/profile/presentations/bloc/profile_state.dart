part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    @Default(false) bool updateProfileSuccess,
    UserModel? userModel,
  }) = _ProfileState;
}
