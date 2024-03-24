part of 'navigator.dart';

@freezed
class ScreenType with _$ScreenType {
  const factory ScreenType.splash() = ScreenTypeSplash;
  const factory ScreenType.login() = ScreenTypeLogin;
  const factory ScreenType.signup() = ScreenTypeSignup;
  const factory ScreenType.home() = ScreenTypeHome;
  const factory ScreenType.productDetail(ProductModel productModel) =
      ScreenTypeProductDetail;
  const factory ScreenType.cart() = ScreenTypeCart;
}

class ScreenTypeHelper {
  static Widget page(ScreenType screenType) {
    return screenType.when(
      splash: () => const SplashPage(),
      login: () => const LoginPage(),
      signup: () => const SignUpPage(),
      home: () => const HomePage(),
      productDetail: (productModel) =>
          ProductDetailPage(productModel: productModel),
      cart: () => const CartPage(),
    );
  }
}
