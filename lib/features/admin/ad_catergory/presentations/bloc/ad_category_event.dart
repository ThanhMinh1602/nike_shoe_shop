part of 'ad_category_bloc.dart';

@freezed
class AdCategoryEvent with _$AdCategoryEvent {
  const factory AdCategoryEvent.initialEvent() = AdCategoryInitialEvent;
  const factory AdCategoryEvent.adImagePickerEvent() = AdImagePickerEvent;
  const factory AdCategoryEvent.adAddNewCategoryEvent(
      CategoryModel addCategoryModel) = AdAddNewCategoryEvent;
  const factory AdCategoryEvent.adCategoryDeleteEvent(String idCate) =
      AdDeleteCategoryEvent;
  const factory AdCategoryEvent.adCategoryUpdateEvent(
      CategoryModel updateCategoryModel) = AdUpdateCategoryEvent;
}
