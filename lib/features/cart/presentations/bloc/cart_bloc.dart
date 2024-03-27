import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/features/cart/data/cart_repository_impl.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepositoryImpl repository;
  final AppNavigator appNavigator;
  CartBloc({
    required this.appNavigator,
    required this.repository,
  }) : super(const CartInitialState()) {
    on(_onInit);
    on(_onRemoveProductFromCart);
    on(_onChangeQuantity);
    on(_onCalculateTotalPrice);
    on(_onCheckout);
  }
}

extension CartBlocExtension on CartBloc {
  Future<void> _onInit(
      CartInitialEvent event, Emitter<CartState> emitter) async {
    emitter(const CartInitialState(isLoading: true));
    final List<CartModel> cartProducts = await repository.getCartProducts();
    emitter(state.copyWith(
      isLoading: false,
      listCart: cartProducts,
    ));
    add(const CalculateTotalPriceEvent());
  }

  Future<void> _onRemoveProductFromCart(
      RemoveProductFromCartEvent event, Emitter<CartState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    await repository.removeProductFromCart(event.productId);
    final List<CartModel> cartProducts = await repository.getCartProducts();
    emitter(state.copyWith(
      isLoading: false,
      listCart: cartProducts,
    ));
    add(const CalculateTotalPriceEvent());
  }

  Future<void> _onChangeQuantity(
      OnChangeQuantityItemEvent event, Emitter<CartState> emitter) async {
    await repository.changeQuantity(event.productId, event.quantity);
    add(const CalculateTotalPriceEvent());
  }

  Future<void> _onCalculateTotalPrice(
      CalculateTotalPriceEvent event, Emitter<CartState> emitter) async {
    double totalPrice = 0;
    int totalProduct = 0;
    final List<CartModel> cartProducts = await repository.getCartProducts();
    for (var cartItem in cartProducts) {
      totalPrice += cartItem.productPrice * cartItem.quantity;
      totalProduct += cartItem.quantity;
    }
    emitter(state.copyWith(totalPrice: totalPrice, totalProduct: totalProduct));
  }

  Future<void> _onCheckout(
      OnTapCheckoutEvent event, Emitter<CartState> emitter) async {
    appNavigator.push(
        screen: ScreenType.checkout(
            totalPrice: event.totalPrice, totalProduct: event.totalProduct));
  }
}
