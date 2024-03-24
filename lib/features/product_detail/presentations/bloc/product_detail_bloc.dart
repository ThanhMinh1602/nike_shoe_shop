import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';
part 'product_detail_bloc.freezed.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final AppNavigator appNavigator;
  ProductDetailBloc({required this.appNavigator})
      : super(const ProductDetailInitalState()) {
    on(_onDetailInitial);
    on(_onTapBack);
    on(_onTapSelectSize);
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

  Future<void> _onTapBack(
      OnTapBackEvent event, Emitter<ProductDetailState> emitter) async {
    appNavigator.pop();
  }

  void _onTapSelectSize(
      OnTapSelectSizeEvent event, Emitter<ProductDetailState> emitter) {
    emitter(state.copyWith(selectedSize: event.size));
  }
}
