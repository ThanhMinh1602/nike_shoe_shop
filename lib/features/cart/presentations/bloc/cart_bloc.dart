import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/features/cart/data/cart_repository_impl.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepositoryImpl repository;
  CartBloc({
    required this.repository,
  }) : super(const CartInitialState()) {
    on(_onInit);
    on(_onRemoveProductFromCart);
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
  }
}
