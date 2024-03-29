import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_catergory/data/ad_category_repository_inpl.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/domain/usecase/ad_image_picker_usecase.dart';

part 'ad_category_event.dart';
part 'ad_category_state.dart';
part 'ad_category_bloc.freezed.dart';

class AdCategoryBloc extends Bloc<AdCategoryEvent, AdCategoryState> {
  final AdImagePickerUseCase adImagePickerUseCase;
  final AdCategoryRepositoryImpl repository;

  AdCategoryBloc({
    required this.adImagePickerUseCase,
    required this.repository,
  }) : super(const _AdCategoryState()) {
    on(_onInitial);
    on(_onPickImage);
    on(_onSubmitCategory);
  }
}

extension AdCategoryBlocExtension on AdCategoryBloc {
  Future<void> _onInitial(
      AdCategoryInitialEvent event, Emitter<AdCategoryState> emitter) async {}
  Future<void> _onPickImage(
      AdImagePickerEventEvent event, Emitter<AdCategoryState> emitter) async {
    final imageFile = await adImagePickerUseCase();
    emitter(state.copyWith(imageFile: imageFile));
  }

  Future<void> _onSubmitCategory(
      AdAddNewCategoryEvent event, Emitter<AdCategoryState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    await repository.addNewCategory(event.addCategoryModel);
    emitter(state.copyWith(
        isLoading: false, addNewCategorySuccess: true, imageFile: null));
    emitter(state.copyWith(addNewCategorySuccess: false));
  }
}
