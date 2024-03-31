import 'package:flutter/widgets.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/product_detail/domain/data/product_detail_repository_impl.dart';
import 'package:nike_shoe_shop/features/product_detail/presentations/bloc/product_detail_bloc.dart';

class ProductDetailBinding {
  static ProductDetailBloc generateBloc(BuildContext context) {
    return ProductDetailBloc(
      appNavigator: context.getNavigator(),
      repository: ProductDetailRepositoryImpl(),
    );
  }
}
