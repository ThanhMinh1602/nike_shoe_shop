part of 'product_detail_bloc.dart';

@freezed
class ProductDetailEvent with _$ProductDetailEvent {
  const factory ProductDetailEvent.initialEvent(ProductModel product) =
      ProductDetailInitialEvent;
  const factory ProductDetailEvent.onTapSelectSizeEvent(int size) =
      OnTapSelectSizeEvent;
}
