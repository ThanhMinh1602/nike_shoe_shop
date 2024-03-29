part of 'ad_category_bloc.dart';

@freezed
class AdCategoryState with _$AdCategoryState {
  const factory AdCategoryState({
    @Default(false) bool isLoading,
    @Default(0) int idCate,
    @Default(false) bool addNewCategorySuccess,
    @Default([]) List<CategoryModel> categories,
    File? imageFile,
  }) = _AdCategoryState;
}
