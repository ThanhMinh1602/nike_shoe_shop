part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.cartInitialEvent() = CartInitialEvent;
  const factory CartEvent.removeProductFromCartEvent(String productId) =
      RemoveProductFromCartEvent;
  const factory CartEvent.onChangeQuantityItemEvent(
      String productId, int quantity) = OnChangeQuantityItemEvent;
  const factory CartEvent.calculateTotalPriceEvent() = CalculateTotalPriceEvent;
  const factory CartEvent.onTapChekoutEvent(
      {required int totalProduct,
      required double totalPrice}) = OnTapCheckoutEvent;
}
