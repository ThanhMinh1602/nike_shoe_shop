import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/features/user/checkout/data/checkout_repository_impl.dart';
import 'package:nike_shoe_shop/features/user/checkout/presentations/bloc/checkout_bloc.dart';

class CheckoutBinding {
  static CheckoutBloc generateBloc(BuildContext context) {
    return CheckoutBloc(
      repository: CheckoutRepositoryImpl(),
    );
  }
}
