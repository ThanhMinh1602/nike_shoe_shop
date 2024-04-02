import 'dart:io';

import 'package:nike_shoe_shop/entities/models/user_model.dart';

abstract class IProfileRepository {
  Future<void> updateUser(File imageFile, UserModel userModel);
  Future<UserModel> userData();
}
