import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/login_request.dart';
import 'package:nike_shoe_shop/features/auth/login/domain/usecase/set_token_usecase.dart';
import 'package:nike_shoe_shop/services/remote/auth_service.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppNavigator appNavigator;
  final AuthService authService;
  final SetTokenUseCase setTokenUseCase;
  LoginBloc({
    required this.appNavigator,
    required this.authService,
    required this.setTokenUseCase,
  }) : super(const _InitialState()) {
    on(_onTapToSignUp);
    on(_onTapToLogin);
  }
}

extension LoginBlocExtension on LoginBloc {
  void _onTapToSignUp(OnTapToSignUpEvent event, Emitter<LoginState> emit) {
    appNavigator.push(screen: const ScreenType.signup());
  }

  Future<void> _onTapToLogin(
      OnTapLoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await authService.signInWithEmail(event.loginRequest);
    emit(state.copyWith(isLoading: false));
    if (result == SigninResult.success) {
      await setTokenUseCase();
      appNavigator.pushAndRemoveUntil(screen: const ScreenType.home());
    } else {
      EasyLoading.showError('Email or password is incorrect');
    }
  }
}
