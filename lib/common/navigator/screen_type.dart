part of 'navigator.dart';

@freezed
class ScreenType with _$ScreenType {
  //mobile
  const factory ScreenType.splash() = ScreenTypeSplash;
  const factory ScreenType.login() = ScreenTypeLogin;
  const factory ScreenType.signup() = ScreenTypeSignup;
  const factory ScreenType.recovery() = ScreenTypePasswordRecovery;
  const factory ScreenType.home() = ScreenTypeHome;
  const factory ScreenType.productDetail(ProductModel productModel) =
      ScreenTypeProductDetail;
  const factory ScreenType.cart() = ScreenTypeCart;
  const factory ScreenType.checkout(
      {required int totalProduct,
      required double totalPrice}) = ScreenTypeCheckout;
  const factory ScreenType.profile(UserModel userModel) = ScreenTypeProfile;
  const factory ScreenType.order() = ScreenTypeOrder;
}

class ScreenTypeHelper {
  static Widget page(ScreenType screenType) {
    return screenType.when(
        splash: () => const SplashPage(),
        login: () => const LoginPage(),
        recovery: () => const RecoveryPasswordPage(),
        signup: () => const SignUpPage(),
        home: () => const HomePage(),
        productDetail: (productModel) =>
            ProductDetailPage(productModel: productModel),
        cart: () => const CartPage(),
        checkout: (totalProduct, totalPrice) =>
            CheckoutPage(totalPrice: totalPrice, totalProduct: totalProduct),
        profile: (userModel) => ProfilePage(
              userModel: userModel,
            ),
        order: () => const OrderPage());
  }
}
