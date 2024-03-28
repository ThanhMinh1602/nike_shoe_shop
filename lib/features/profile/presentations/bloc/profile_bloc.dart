import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';
import 'package:nike_shoe_shop/features/home/presentations/bloc/home_bloc.dart';
import 'package:nike_shoe_shop/features/profile/data/profile_repository_impl.dart';
import 'package:nike_shoe_shop/features/profile/domain/usecase/profile_image_picker_usecase.dart';
part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepositoryImpl repository;
  final ProfileImagePickerUseCase imagePickerUsecase;
  ProfileBloc({
    required this.imagePickerUsecase,
    required this.repository,
  }) : super(const _ProfileState()) {
    on(_onInitial);
    on(_onUpdateProfile);
    on(_onTapImagePicker);
    add(const ProfileInitialEvent());
  }
}

extension ProfileBlocExtension on ProfileBloc {
  Future<void> _onInitial(
      ProfileInitialEvent event, Emitter<ProfileState> emitter) async {
    final user = await repository.userData();
    emitter(state.copyWith(userModel: user));
  }

  Future<void> _onUpdateProfile(
      OnTapUpDateProfileEvent event, Emitter<ProfileState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    await repository.updateUser(event.imageFile, event.userModel);
    emitter(state.copyWith(
      isLoading: false,
      updateProfileSuccess: true,
    ));
  }

  Future<void> _onTapImagePicker(
      OnTapPickImageEvent event, Emitter<ProfileState> emitter) async {
    final imageFile = await imagePickerUsecase();
    emitter(state.copyWith(imageFile: imageFile));
  }
}
