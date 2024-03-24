import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/auth/login/presentations/page/login_page.dart';
import 'package:nike_shoe_shop/features/auth/signup/presentations/page/signup_page.dart';
import 'package:nike_shoe_shop/features/cart/presentations/page/cart_page.dart';
import 'package:nike_shoe_shop/features/home/presentations/page/home_page.dart';
import 'package:nike_shoe_shop/features/product_detail/presentations/page/product_detail_page.dart';
import 'package:nike_shoe_shop/features/splash/presentations/page/splash_page.dart';
import 'package:page_transition/page_transition.dart';

part 'screen_type.dart';
part 'navigation_type.dart';
part 'navigator.freezed.dart';

class AppNavigator {
  AppNavigator({required this.current});
  final NavigatorState current;
  factory AppNavigator.fromContext(BuildContext context) {
    final state = Navigator.of(context);
    return AppNavigator(current: state);
  }
  static final Map<NavigationType, GlobalKey<NavigatorState>> _store = {};
  static GlobalKey<NavigatorState> getNavigatorKey(NavigationType type) {
    var state = _store[type];
    if (state == null) {
      state = GlobalKey<NavigatorState>();
      _store[type] = state;
    }
    return state;
  }

  Future<T?> push<T extends Object?>(
      {required ScreenType screen,
      NavigationType? type,
      PageTransitionType? pageTransitionType,
      Alignment? alignment}) async {
    return _getNavigator(type: type).push<T>(
      PageTransition(
        type: pageTransitionType ?? PageTransitionType.rightToLeft,
        alignment: alignment,
        child: ScreenTypeHelper.page(screen),
      ),
    );
  }

  Future<T?> pushReplace<T extends Object?, TO extends Object?>({
    required ScreenType screen,
    NavigationType? type,
    TO? result,
  }) async {
    return _getNavigator(type: type).pushReplacement(
      PageTransition(
        settings: RouteSettings(
          name: screen.toString(),
        ),
        type: PageTransitionType.rightToLeft,
        child: ScreenTypeHelper.page(screen),
      ),
      result: result,
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?, TO extends Object?>({
    required ScreenType screen,
    NavigationType? type,
  }) async {
    return _getNavigator(type: type).pushAndRemoveUntil(
      PageTransition(
        settings: RouteSettings(
          name: screen.toString(),
        ),
        type: PageTransitionType.rightToLeft,
        child: ScreenTypeHelper.page(screen),
      ),
      (route) => false,
    );
  }

  void pop<T extends Object?>({
    T? callback,
    NavigationType? type,
  }) {
    _getNavigator(type: type).pop(callback);
  }

  void popToScreen({required ScreenType screen, NavigationType? type}) {
    _getNavigator(type: type).popUntil((route) {
      return route.settings.name == screen.toString();
    });
  }
}

extension _PrivateFunction on AppNavigator {
  NavigatorState _getNavigator({NavigationType? type}) {
    if (type == null) {
      return current;
    }
    final keyNavigator = AppNavigator.getNavigatorKey(type).currentState;
    if (keyNavigator == null) {
      return current;
    }
    return keyNavigator;
  }
}
