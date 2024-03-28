part of 'admin_dashboard_bloc.dart';

@freezed
class AdminDashboardEvent with _$AdminDashboardEvent {
  const factory AdminDashboardEvent.adminDashBoardInitialEvent() =
      AdminDashBoardInitialEvent;
  const factory AdminDashboardEvent.adminDashBoardChangePageEvent(int index) =
      AdminDashBoardChangePageEvent;
}
