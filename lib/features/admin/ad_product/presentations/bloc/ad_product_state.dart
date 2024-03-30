part of 'ad_product_bloc.dart';

@freezed
class AdProductState with _$AdProductState {
  const factory AdProductState({
    @Default(false) bool isLoading,
    @Default(false) bool addNewProductSuccess,
    @Default(false) bool updateProductSuccess,
    @Default(false) bool deleteProductSuccess,
    @Default([]) List<CategoryModel> categories,
    @Default([]) List<ProductModel> products,
    CategoryModel? categoryModel,
    File? imageFileUpload,
    File? imageFileEdit,
  }) = _AdProductState;
}
