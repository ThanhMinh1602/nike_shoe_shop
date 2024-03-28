part of 'admin_category_bloc.dart';

@freezed
class AdminCategoryEvent with _$AdminCategoryEvent {
  const factory AdminCategoryEvent.adminCategoryInitialEvent() =
      AdminCategoryInitialEvent;
}
