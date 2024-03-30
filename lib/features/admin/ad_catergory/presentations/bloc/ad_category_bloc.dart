import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_catergory/data/ad_category_repository_impl.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/domain/usecase/ad_image_picker_usecase.dart';

part 'ad_category_event.dart';
part 'ad_category_state.dart';
part 'ad_category_bloc.freezed.dart';

class AdCategoryBloc extends Bloc<AdCategoryEvent, AdCategoryState> {
  final AdImagePickerUseCase adImagePickerUseCase;
  final AdCategoryRepositoryImpl repository;
  final AppNavigator appNavigator;

  AdCategoryBloc({
    required this.appNavigator,
    required this.adImagePickerUseCase,
    required this.repository,
  }) : super(const _AdCategoryState()) {
    on(_onInitial);
    on(_onPickImage);
    on(_onSubmitCategory);
    on(_onDeleteCategory);
    on(_onUpdateCategory);
    add(const AdCategoryInitialEvent());
  }
}

extension AdCategoryBlocExtension on AdCategoryBloc {
  Future<void> _onInitial(
      AdCategoryInitialEvent event, Emitter<AdCategoryState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    final categories = await repository.getAllCategory();
    emitter(state.copyWith(isLoading: false, categories: categories));
  }

  Future<void> _onPickImage(
      AdImagePickerEvent event, Emitter<AdCategoryState> emitter) async {
    final imageFile = await adImagePickerUseCase();
    emitter(state.copyWith(imageFile: imageFile));
  }

  Future<void> _onSubmitCategory(
      AdAddNewCategoryEvent event, Emitter<AdCategoryState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    await repository.addNewCategory(event.addCategoryModel);
    emitter(state.copyWith(isLoading: false, imageFile: null));
    appNavigator.pop();
    add(const AdCategoryInitialEvent());
  }

  Future<void> _onDeleteCategory(
      AdDeleteCategoryEvent event, Emitter<AdCategoryState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    await repository.deleteCategory(event.idCate);
    emitter(state.copyWith(isLoading: false));
    add(const AdCategoryInitialEvent());
  }

  Future<void> _onUpdateCategory(
      AdUpdateCategoryEvent event, Emitter<AdCategoryState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    await repository.updateCategory(event.updateCategoryModel);
    emitter(state.copyWith(isLoading: false));
    appNavigator.pop();
    add(const AdCategoryInitialEvent());
  }
}
