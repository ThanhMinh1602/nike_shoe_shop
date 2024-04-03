part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.checkoutInitialEvent() = CheckoutInitialEvent;
  const factory CheckoutEvent.onTapPaymentEvent(PaymentModel paymentModel) =
      OnTapPaymentEvent;
  const factory CheckoutEvent.onTapSelectPaymentEvent(PaymentMethod paymentMethod) =
      OnTapSelectPaymentEvent;
  const factory CheckoutEvent.paypalPaymentEvent(String totalPrice) =
      PaypalPaymentEvent;
}
