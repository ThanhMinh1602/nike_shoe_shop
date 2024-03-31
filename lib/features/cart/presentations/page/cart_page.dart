import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/cart/presentations/binding/cart_binding.dart';
import 'package:nike_shoe_shop/features/cart/presentations/widgets/cart_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvider(
      create: CartBinding.generateCartBloc,
      child: CartWidget(),
    );
  }
}
