import 'package:nike_shoe_shop/entities/models/requests/login_request.dart';
import 'package:nike_shoe_shop/services/sevice_status.dart';

abstract class IAdminLoginReposiry {
  Future<SigninResult> adminLogin(LoginRequest loginRequest);
}
