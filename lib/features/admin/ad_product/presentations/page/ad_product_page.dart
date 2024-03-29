import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/presentations/binding/ad_product_binding.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/presentations/widgets/ad_product_widget.dart';

class AdProductPage extends StatelessWidget {
  const AdProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: AdProductBinding.generateBloc,
      child: AdProductWidget(),
    );
  }
}
