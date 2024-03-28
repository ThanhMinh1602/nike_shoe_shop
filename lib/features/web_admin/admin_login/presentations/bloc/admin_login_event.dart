part of 'admin_login_bloc.dart';

@freezed
class AdminLoginEvent with _$AdminLoginEvent {
  const factory AdminLoginEvent.adminLoginInitialEvent() =
      AdminLoginInitialEvent;
  const factory AdminLoginEvent.adminLoginlEvent(LoginRequest loginRequest) =
      AdminLoginEvents;
}
