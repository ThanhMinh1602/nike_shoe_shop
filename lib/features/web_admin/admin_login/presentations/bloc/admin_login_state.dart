part of 'admin_login_bloc.dart';

@freezed
class AdminLoginState with _$AdminLoginState {
  const factory AdminLoginState({
    @Default(false) bool isLoading,
  }) = _AdminLoginState;
}
