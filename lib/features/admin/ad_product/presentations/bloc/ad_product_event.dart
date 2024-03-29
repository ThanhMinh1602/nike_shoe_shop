part of 'ad_product_bloc.dart';

@freezed
class AdProductEvent with _$AdProductEvent {
  const factory AdProductEvent.productInitialEvent() = ProductInitialEvent;
  const factory AdProductEvent.adImagePickerEventEvent() =
      AdImagePickerEventEvent;
  const factory AdProductEvent.adAddNewProductEvent(
      AddProductModel addProductModel) = AdAddNewProductEvent;
  const factory AdProductEvent.adOnSelectCategoryEvent(
      CategoryModel categoryModel) = AdOnSelectCategoryEvent;
}
