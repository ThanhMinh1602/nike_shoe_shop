import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/product_detail/presentations/binding/product_detail_binding.dart';
import 'package:nike_shoe_shop/features/product_detail/presentations/widgets/product_detail_widget.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailPage({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ProductDetailBinding.generateBloc,
      child: ProductDetailWidget(
        product: productModel,
      ),
    );
  }
}
