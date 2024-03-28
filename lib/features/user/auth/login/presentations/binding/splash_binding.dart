import 'package:flutter/widgets.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/user/auth/login/domain/usecase/set_token_usecase.dart';
import 'package:nike_shoe_shop/features/user/auth/login/presentations/bloc/login_bloc.dart';
import 'package:nike_shoe_shop/services/remote/auth_service.dart';

class LoginBingding {
  static LoginBloc generateBloc(BuildContext context) {
    return LoginBloc(
      appNavigator: context.getNavigator(),
      authService: AuthService(),
      setTokenUseCase: SetTokenUseCase(),
    );
  }
}
