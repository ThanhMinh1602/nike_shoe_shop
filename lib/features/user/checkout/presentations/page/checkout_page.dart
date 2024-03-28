import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/user/checkout/presentations/binding/checkout_binding.dart';
import 'package:nike_shoe_shop/features/user/checkout/presentations/widgets/checkout_widget.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    super.key,
    required this.totalProduct,
    required this.totalPrice,
  });
  final int totalProduct;
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: CheckoutBinding.generateBloc,
      child: CheckoutWidget(
        totalPrice: totalPrice,
        totalProduct: totalProduct,
      ),
    );
  }
}
