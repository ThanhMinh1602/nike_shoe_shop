import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/order/presentations/binding/order_binding.dart';
import 'package:nike_shoe_shop/features/order/presentations/widgets/order_widget.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvider(
      create: OrderBinding.generatebloc,
      child: OrderWidget(),
    );
  }
}
