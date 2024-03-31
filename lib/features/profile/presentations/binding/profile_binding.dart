import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/features/profile/data/profile_repository_impl.dart';
import 'package:nike_shoe_shop/features/profile/domain/usecase/profile_image_picker_usecase.dart';
import 'package:nike_shoe_shop/features/profile/presentations/bloc/profile_bloc.dart';

class ProfileBinding {
  static ProfileBloc generateBloc(BuildContext context) {
    return ProfileBloc(
      repository: ProfileRepositoryImpl(),
      imagePickerUsecase: ProfileImagePickerUseCase(),
    );
  }
}
