import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/product_detail/domain/data/product_detail_repository_impl.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';
part 'product_detail_bloc.freezed.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final AppNavigator appNavigator;
  final ProductDetailRepositoryImpl repository;
  ProductDetailBloc({
    required this.appNavigator,
    required this.repository,
  }) : super(const ProductDetailInitalState()) {
    on(_onDetailInitial);
    on(_onTapSelectSize);
    on(_onAddToCart);
  }
}

extension HandleEvent on ProductDetailBloc {
  Future<void> _onDetailInitial(ProductDetailInitialEvent event,
      Emitter<ProductDetailState> emitter) async {
    emitter(
      state.copyWith(
        isLoading: true,
        selectedSize: event.product.sizes.first,
      ),
    );
  }

  void _onTapSelectSize(
      OnTapSelectSizeEvent event, Emitter<ProductDetailState> emitter) {
    emitter(state.copyWith(selectedSize: event.size));
  }

  Future<void> _onAddToCart(OnTapAddProductToCartEvent event,
      Emitter<ProductDetailState> emitter) async {
    final int result = await repository.addProductToCart(event.cartModel);
    if (result != 0) {
      EasyLoading.showSuccess('Product added to cart successfully!');
    } else {
      EasyLoading.showError('Product added to cart failed!');
    }
  }
}
