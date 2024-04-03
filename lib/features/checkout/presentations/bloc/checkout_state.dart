part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(false) bool isLoading,
    @Default(false) bool paymentSuccess,
    @Default(false) bool isPaypalPayment,
    @Default(PaymentMethod.onDelivery) PaymentMethod paymentMethod,
    UsePaypal? userPaypal,
    @Default([]) List<CartModel> listCart,
  }) = _CheckoutState;
}
