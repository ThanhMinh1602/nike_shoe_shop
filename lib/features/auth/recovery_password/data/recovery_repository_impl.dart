import 'package:nike_shoe_shop/features/auth/recovery_password/domain/repository/recovery_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/auth_service.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

class RecoveryRepositoryImpl implements IRecoveryRepository {
  final AuthService authService = AuthService();
  @override
  Future<ResetPasswordStatus> resetPassword(String email) async {
    return authService.resetPassword(email);
  }
}
