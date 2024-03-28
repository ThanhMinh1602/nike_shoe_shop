import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/features/user/order/data/order_repsitory_impl.dart';
import 'package:nike_shoe_shop/features/user/order/presentations/bloc/order_bloc.dart';

class OrderBinding {
  static OrderBloc generatebloc(BuildContext context) {
    return OrderBloc(
      repository: OrderRepositoryImpl(),
    );
  }
}
