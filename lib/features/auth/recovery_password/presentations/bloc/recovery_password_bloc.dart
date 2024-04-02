import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/features/auth/recovery_password/data/recovery_repository_impl.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

part 'recovery_password_event.dart';
part 'recovery_password_state.dart';
part 'recovery_password_bloc.freezed.dart';

class RecoveryPasswordBloc
    extends Bloc<RecoveryPasswordEvent, RecoveryPasswordState> {
  final RecoveryRepositoryImpl repository;
  final AppNavigator appNavigator;
  RecoveryPasswordBloc({
    required this.repository,
    required this.appNavigator,
  }) : super(const _RecoveryPasswordState()) {
    on(_onInitial);
    on(_onResetPassword);
  }
}

extension RecoveryPasswordBlocExtension on RecoveryPasswordBloc {
  Future<void> _onInitial(RecoveryPasswordInitialEvent event,
      Emitter<RecoveryPasswordState> emitter) async {}
  Future<void> _onResetPassword(RecoveryPasswordResetPasswordEvent event,
      Emitter<RecoveryPasswordState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    final reponse = await repository.resetPassword(event.email);
    if (reponse == ResetPasswordStatus.success) {
      emitter(state.copyWith(isLoading: false));
      appNavigator.pop();
      EasyLoading.showSuccess(
          'Password reset link has been sent to your email!',
          duration: const Duration(seconds: 3));
    } else if (reponse == ResetPasswordStatus.emailNotFound) {
      emitter(state.copyWith(isLoading: false));
      EasyLoading.showError('The email does not exist in the system!',
          duration: const Duration(seconds: 3));
    } else {
      emitter(state.copyWith(isLoading: false));
      EasyLoading.showError('Error sending email',
          duration: const Duration(seconds: 3));
    }
  }
}
