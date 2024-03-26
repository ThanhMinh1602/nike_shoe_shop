import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/requests/payment_model.dart';
import 'package:nike_shoe_shop/features/checkout/data/checkout_repository_impl.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutRepositoryImpl repository;
  CheckoutBloc({required this.repository}) : super(const CheckoutState()) {
    on(_checkoutInitial);
  }
}

extension CheckoutBlocExtension on CheckoutBloc {
  Future<void> _checkoutInitial(
      CheckoutInitialEvent event, Emitter<CheckoutState> emitter) async {
    emitter(const CheckoutState(isLoading: true));
    final List<CartModel> listCart = await repository.getCartProducts();
    emitter(state.copyWith(
      isLoading: false,
      listCart: listCart,
    ));
  }
}
