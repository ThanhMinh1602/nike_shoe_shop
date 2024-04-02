part of 'recovery_password_bloc.dart';

@freezed
class RecoveryPasswordState with _$RecoveryPasswordState {
  const factory RecoveryPasswordState({
    @Default(false) isLoading,
  }) = _RecoveryPasswordState;
}
