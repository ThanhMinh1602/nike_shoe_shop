part of 'recovery_password_bloc.dart';

@freezed
class RecoveryPasswordEvent with _$RecoveryPasswordEvent {
  const factory RecoveryPasswordEvent.initialEvent() =
      RecoveryPasswordInitialEvent;
  const factory RecoveryPasswordEvent.resetPassword(String email) =
      RecoveryPasswordResetPasswordEvent;
}
