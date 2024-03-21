part of 'signup_bloc.dart';

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.signupInitialEvent() = _SignUpInitialEvent;
  const factory SignUpEvent.onTapToLoginEvent() = OnTapToLoginEvent;
  const factory SignUpEvent.onTapSignUpEvent(SignupRequest signupRequest) =
      OnTapSignUpEvent;
}
