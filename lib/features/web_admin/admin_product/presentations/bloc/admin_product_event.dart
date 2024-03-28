part of 'admin_product_bloc.dart';

@freezed
class AdminProductEvent with _$AdminProductEvent {
  const factory AdminProductEvent.adminProductInitialEvent() =
      AdminProductInitialEvent;
  const factory AdminProductEvent.adminOnSelectCategoryEvent(int idCate) =
      AdminOnSelectCategoryEvent;
  const factory AdminProductEvent.adminOnPickImageEvent() =
      AdminOnPickImageEvent;
}
