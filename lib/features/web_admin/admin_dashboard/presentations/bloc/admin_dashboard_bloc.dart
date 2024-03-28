import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';
part 'admin_dashboard_bloc.freezed.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  AdminDashboardBloc() : super(const _AdminDashboardState()) {
    on(_onInitialAdminDashboard);
    on(_onChangePage);
    add(const AdminDashBoardInitialEvent());
  }
}

extension AdminDashboardBlocExtension on AdminDashboardBloc {
  Future<void> _onInitialAdminDashboard(AdminDashBoardInitialEvent event,
      Emitter<AdminDashboardState> emitter) async {
    emitter(state.copyWith(pageIndex: 0));
  }

  Future<void> _onChangePage(AdminDashBoardChangePageEvent event,
      Emitter<AdminDashboardState> emitter) async {
    emitter(state.copyWith(pageIndex: event.index));
  }
}
