part of 'ad_category_bloc.dart';

@freezed
class AdCategoryState with _$AdCategoryState {
  const factory AdCategoryState({
    @Default(false) bool isLoading,
    @Default(false) bool addNewCategorySuccess,
    @Default(false) bool updateCategorySuccess,
    @Default(false) bool deleteCategorySuccess,
    @Default([]) List<CategoryModel> categories,
    String? idCate,
    File? imageFile,
  }) = _AdCategoryState;
}
