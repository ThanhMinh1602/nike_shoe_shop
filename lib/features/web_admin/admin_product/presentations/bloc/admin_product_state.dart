part of 'admin_product_bloc.dart';

@freezed
class AdminProductState with _$AdminProductState {
  const factory AdminProductState({
    @Default(false) bool isLoading,
    @Default([]) List<CategoryModel> categories,
    @Default(0) int idCate,
    Uint8List? imageFile,
  }) = _AdminAddProductState;
}
