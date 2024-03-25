part of 'cart_bloc.dart';

@freezed
class CartEvent with _$CartEvent {
  const factory CartEvent.cartInitialEvent() = CartInitialEvent;
  const factory CartEvent.removeProductFromCartEvent(int productId) =
      RemoveProductFromCartEvent;
}
