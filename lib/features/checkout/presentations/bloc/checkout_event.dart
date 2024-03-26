part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.checkoutInitialEvent() = CheckoutInitialEvent;
  const factory CheckoutEvent.onTapPaymentEvent(PaymentModel paymentModel) =
      OnTapPaymentEvent;
}
