import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_home_event.dart';
part 'ad_home_state.dart';
part 'ad_home_bloc.freezed.dart';

class AdHomeBloc extends Bloc<AdHomeEvent, AdHomeState> {
  AdHomeBloc() : super(const _AdHomeState()) {
    on<AdHomeEvent>((event, emit) {});
  }
}
