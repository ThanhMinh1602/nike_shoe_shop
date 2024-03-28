import 'package:nike_shoe_shop/entities/models/requests/login_request.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_login/domain/repository/admin_login_repositpry_interface.dart';
import 'package:nike_shoe_shop/services/remote/admin_auth_service.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

class AdminLoginRepositoryImpl implements IAdminLoginReposiry {
  final AdminAuthService adminAuthService = AdminAuthService();

  @override
  Future<SigninResult> adminLogin(LoginRequest loginRequest) async {
    return await adminAuthService.adminSignInWithEmail(loginRequest);
  }
}
