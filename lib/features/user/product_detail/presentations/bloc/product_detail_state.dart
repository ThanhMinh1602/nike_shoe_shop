part of 'product_detail_bloc.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState({
    @Default(false) bool isLoading,
    int? selectedSize,
  }) = ProductDetailInitalState;
}
