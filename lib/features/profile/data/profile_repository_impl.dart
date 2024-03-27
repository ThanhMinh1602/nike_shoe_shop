import 'dart:io';

import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';
import 'package:nike_shoe_shop/features/profile/domain/repository/profile_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/auth_service.dart';
import 'package:nike_shoe_shop/services/remote/profile_service.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  ProfileService profileService = ProfileService();
  AuthService authService = AuthService();

  @override
  Future<void> updateUser(File imageFile, UserModel userModel) async {
    await authService.updatePassword(userModel.password!);
    await profileService.updateUser(imageFile, userModel);
  }

  @override
  Future<UserModel> userData() async {
    return await profileService.fetchUserByUid();
  }
}
