import 'package:flutter/widgets.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/user/auth/signup/presentations/bloc/signup_bloc.dart';
import 'package:nike_shoe_shop/services/remote/auth_service.dart';

class SignUpBingding {
  static SignUpBloc generateBloc(BuildContext context) {
    return SignUpBloc(
      appNavigator: context.getNavigator(),
      authService: AuthService(),
    );
  }
}
