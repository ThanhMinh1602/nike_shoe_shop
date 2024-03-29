part of 'ad_category_bloc.dart';

@freezed
class AdCategoryEvent with _$AdCategoryEvent {
  const factory AdCategoryEvent.initialEvent() = AdCategoryInitialEvent;
  const factory AdCategoryEvent.adImagePickerEventEvent() =
      AdImagePickerEventEvent;
  const factory AdCategoryEvent.adAddNewCategoryEvent(
      CategoryModel addCategoryModel) = AdAddNewCategoryEvent;
}
