import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/requests/add_product_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/data/product_repository_impl.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/domain/usecase/ad_image_picker_usecase.dart';

part 'ad_product_event.dart';
part 'ad_product_state.dart';
part 'ad_product_bloc.freezed.dart';

class AdProductBloc extends Bloc<AdProductEvent, AdProductState> {
  final AdImagePickerUseCase adImagePickerUseCase;
  final ProductRepositoryImpl repository;
  final AppNavigator appNavigator;
  AdProductBloc({
    required this.appNavigator,
    required this.adImagePickerUseCase,
    required this.repository,
  }) : super(const _AdProductState()) {
    on(_onInitial);
    on(_onPickImage);
    on(_onSelectCategory);
    on(_onSubmitProduct);
    on(_onDeleteProduct);
    add(const ProductInitialEvent());
  }
}

extension AdProductBlocExtension on AdProductBloc {
  Future<void> _onInitial(
      ProductInitialEvent event, Emitter<AdProductState> emitter) async {
    try {
      emitter(state.copyWith(isLoading: true));
      final categories = await repository.getAllCategory();
      final products = await repository.getAllProduct();
      emitter(state.copyWith(
        categories: categories,
        products: products,
        isLoading: false,
      ));
      if (categories.isNotEmpty) {
        add(AdOnSelectCategoryEvent(categories[0]));
      }
    } catch (e) {
      print('Error loading categories: $e');
      emitter(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onSelectCategory(
      AdOnSelectCategoryEvent event, Emitter<AdProductState> emitter) async {
    emitter(state.copyWith(
      categoryModel: event.categoryModel,
    ));
  }

  Future<void> _onPickImage(
      AdImagePickerEventEvent event, Emitter<AdProductState> emitter) async {
    final imageFile = await adImagePickerUseCase();
    emitter(state.copyWith(
      imageFileUpload: imageFile,
    ));
  }

  Future<void> _onSubmitProduct(
      AdAddNewProductEvent event, Emitter<AdProductState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    await repository.addNewProduct(event.addProductModel);
    emitter(state.copyWith(
      isLoading: false,
      imageFileUpload: null,
    ));
    appNavigator.pop();
    add(const ProductInitialEvent());
  }

  Future<void> _onDeleteProduct(
      AdDeleteProductEvent event, Emitter<AdProductState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    await repository.deleteProduct(event.idProduct);
    emitter(state.copyWith(
      isLoading: false,
    ));
    add(const ProductInitialEvent());
  }
}
