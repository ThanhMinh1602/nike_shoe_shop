part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<ProductModel> bestSalerProducts,
    @Default([]) List<ProductModel> searchProductsResult,
    @Default([]) List<CategoryModel> categories,
    @Default(false) bool addProductToCartSuccess,
    @Default(false) bool isLoadMorePopular,
    String? cateId,
    ProductModel? newProduct,
    UserModel? userModel,
  }) = HomeInitialState;
}
