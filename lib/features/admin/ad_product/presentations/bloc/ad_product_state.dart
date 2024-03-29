part of 'ad_product_bloc.dart';

@freezed
class AdProductState with _$AdProductState {
  const factory AdProductState({
    @Default(false) bool isLoading,
    CategoryModel? categoryModel,
    @Default(false) bool addNewProductSuccess,
    @Default([]) List<CategoryModel> categories,
    File? imageFile,
  }) = _AdProductState;
}
