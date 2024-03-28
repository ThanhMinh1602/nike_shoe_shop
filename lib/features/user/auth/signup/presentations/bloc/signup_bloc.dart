import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/requests/signup_request.dart';
import 'package:nike_shoe_shop/services/remote/auth_service.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_bloc.freezed.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AppNavigator appNavigator;
  final AuthService authService;
  SignUpBloc({
    required this.appNavigator,
    required this.authService,
  }) : super(const _SignUpInitialState()) {
    on(_onTapToLogin);
    on(_onTapToSignUp);
  }
}

extension SignUpBlocExtension on SignUpBloc {
  void _onTapToLogin(OnTapToLoginEvent event, Emitter<SignUpState> emit) {
    appNavigator.pop();
  }

  Future<void> _onTapToSignUp(
      OnTapSignUpEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await authService.signUpWithEmail(event.signupRequest);
    emit(state.copyWith(isLoading: false));
    if (result == SignupResult.success) {
      EasyLoading.showSuccess('Sign up success');
      appNavigator.pop();
    } else if (result == SignupResult.emailAlreadyExists) {
      EasyLoading.showToast('Email already exists');
    } else if (result == SignupResult.invalidEmail) {
      EasyLoading.showToast('Invalid email');
    } else {
      EasyLoading.showError('Sign up failed');
    }
  }
}
