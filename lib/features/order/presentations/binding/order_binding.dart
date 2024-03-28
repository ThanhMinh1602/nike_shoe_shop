import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/features/order/data/order_repsitory_impl.dart';
import 'package:nike_shoe_shop/features/order/presentations/bloc/order_bloc.dart';

class OrderBinding {
  static OrderBloc generatebloc(BuildContext context) {
    return OrderBloc(
      repository: OrderRepositoryImpl(),
    );
  }
}
