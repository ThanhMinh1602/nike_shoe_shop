import 'package:nike_shoe_shop/services/sevice_status.dart';

abstract class IRecoveryRepository {
  Future<ResetPasswordStatus> resetPassword(String email);
}
