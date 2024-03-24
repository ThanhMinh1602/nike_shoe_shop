part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<ProductModel> bestSalerProducts,
    @Default([]) List<CategoryModel> categories,
    ProductModel? newProduct,
    @Default(false) bool? isLoadMorePopular,
    @Default(false) bool? isLoadMoreNewArrival,
    @Default(0) int selectedCategoryIndex,
  }) = HomeInitialState;
}
