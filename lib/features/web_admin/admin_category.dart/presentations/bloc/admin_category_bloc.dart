import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_category_event.dart';
part 'admin_category_state.dart';
part 'admin_category_bloc.freezed.dart';

class AdminCategoryBloc extends Bloc<AdminCategoryEvent, AdminCategoryState> {
  AdminCategoryBloc() : super(const _AdminCategoryState()) {
    on<AdminCategoryEvent>((event, emit) {});
  }
}
