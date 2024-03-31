part of 'cart_bloc.dart';

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(false) bool isLoading,
    @Default(false) bool isRemoved,
    @Default([]) List<CartModel> listCart,
    double? totalPrice,
    int? totalProduct,
  }) = CartInitialState;
}
