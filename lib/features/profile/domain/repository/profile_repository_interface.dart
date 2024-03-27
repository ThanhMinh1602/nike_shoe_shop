import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';

abstract class IProfileRepository {
  Future<void> updateUser(UserModel userModel);
  Future<UserModel> userData();
}
