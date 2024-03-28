part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.orderState({
    @Default(false) bool isLoading,
    @Default([]) List<PaymentModel> orderList,
  }) = _OrderState;
}
