import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/entities/models/payment_model.dart';
import 'package:nike_shoe_shop/features/order/data/order_repsitory_impl.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepositoryImpl repository;
  OrderBloc({required this.repository}) : super(const _OrderState()) {
    on(_onInitialOrder);
  }
}

extension OrderBlocExtension on OrderBloc {
  Future<void> _onInitialOrder(
      OrderInitialEvent event, Emitter<OrderState> emitter) async {
    emitter(state.copyWith(isLoading: false));
    final listOrder = await repository.getOrder();
    emitter(state.copyWith(isLoading: false, orderList: listOrder));
  }
}
