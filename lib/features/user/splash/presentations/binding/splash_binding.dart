import 'package:flutter/widgets.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/user/splash/presentations/bloc/splash_bloc.dart';
import 'package:nike_shoe_shop/features/user/splash/usecase/check_token_usecase.dart';
import 'package:nike_shoe_shop/features/user/splash/usecase/count_down_usecase.dart';

class SplashBinding {
  static SplashBloc generateBloc(BuildContext context) {
    return SplashBloc(
      appNavigator: context.getNavigator(),
      countDownUsecase: CountDownUseCase(),
      checkTokenUseCase: CheckTokenUseCase(),
    );
  }
}
