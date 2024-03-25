import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/features/cart/data/cart_repository_impl.dart';
import 'package:nike_shoe_shop/features/cart/presentations/bloc/cart_bloc.dart';

class CartBinding {
  static CartBloc generateCartBloc(BuildContext context) {
    return CartBloc(
      repository: CartRepositoryImpl(),
    );
  }
}
