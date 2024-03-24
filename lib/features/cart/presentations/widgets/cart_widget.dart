import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: const Center(
        child: Text('Cart Page'),
      ),
    );
  }
}
