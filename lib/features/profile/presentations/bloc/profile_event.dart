part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.profileInitialEvent() = ProfileInitialEvent;
  const factory ProfileEvent.onTapUpDateProfileEvent(
      UserModel userModel, File imageFile) = OnTapUpDateProfileEvent;
  const factory ProfileEvent.onTapPickImageEvent() = OnTapPickImageEvent;
}
