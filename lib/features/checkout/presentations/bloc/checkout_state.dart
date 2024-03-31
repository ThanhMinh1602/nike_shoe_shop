part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState({
    @Default(false) isLoading,
    @Default(false) paymentSuccess,
    @Default([]) List<CartModel> listCart,
  }) = _CheckoutState;
}
