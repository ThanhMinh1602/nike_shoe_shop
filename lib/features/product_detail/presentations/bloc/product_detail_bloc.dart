import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';
part 'product_detail_bloc.freezed.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final AppNavigator appNavigator;
  ProductDetailBloc({required this.appNavigator})
      : super(const ProductDetailInitalState()) {
    on(_onTapBack);
  }
}

extension HandleEvent on ProductDetailBloc {
  Future<void> _onTapBack(
      OnTapBackEvent event, Emitter<ProductDetailState> emitter) async {
    appNavigator.pop();
  }
}
