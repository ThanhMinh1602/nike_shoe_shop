import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/features/splash/usecase/check_token_usecase.dart';
import 'package:nike_shoe_shop/features/splash/usecase/count_down_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';
part 'splash_bloc.freezed.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppNavigator appNavigator;
  final CountDownUseCase countDownUsecase;
  final CheckTokenUseCase checkTokenUseCase;

  SplashBloc(
      {required this.checkTokenUseCase,
      required this.appNavigator,
      required this.countDownUsecase})
      : super(const SplashState()) {
    on(_onInit);
    add(const SplashInitializeEvent());
  }
}

extension EventHandle on SplashBloc {
  Future<void> _onInit(
      SplashInitializeEvent event, Emitter<SplashState> emitter) async {
    await countDownUsecase();
    try {
      final hasToken = await checkTokenUseCase();
      if (hasToken) {
        appNavigator.pushReplace(screen: const ScreenType.home());
      } else {
        appNavigator.pushReplace(screen: const ScreenType.login());
      }
    } catch (e) {
      Exception(e);
    }
  }
}
