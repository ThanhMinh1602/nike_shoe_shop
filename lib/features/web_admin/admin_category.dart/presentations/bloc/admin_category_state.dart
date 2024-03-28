part of 'admin_category_bloc.dart';

@freezed
class AdminCategoryState with _$AdminCategoryState {
  const factory AdminCategoryState({
    @Default(false) bool isLoading,
  }) = _AdminCategoryState;
}
