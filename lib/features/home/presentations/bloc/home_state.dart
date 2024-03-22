part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<ProductModel> bestSalerProducts,
    @Default([]) List<ProductModel> newProducts,
    @Default([]) List<CategoryModel> categories,
    @Default(false) bool? isLoadMorePopular,
    @Default(false) bool? isLoadMoreNewArrival,
  }) = HomeInitialState;
}
