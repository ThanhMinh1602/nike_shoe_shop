part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loginInitEvent() = LoginInitEvent;
  const factory LoginEvent.onTapToSignUpEvent() = OnTapToSignUpEvent;
  const factory LoginEvent.onTapLoginEvent(
    LoginRequest loginRequest,
  ) = OnTapLoginEvent;
}
