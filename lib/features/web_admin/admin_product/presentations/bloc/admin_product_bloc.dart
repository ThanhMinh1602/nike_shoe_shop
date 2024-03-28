import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/data/admin_product_impl.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/domain/usecase/ImagePickerUseCase.dart';

part 'admin_product_event.dart';
part 'admin_product_state.dart';
part 'admin_product_bloc.freezed.dart';

class AdminProductBloc extends Bloc<AdminProductEvent, AdminProductState> {
  final AdminProductRepositoryImpl repository;
  final ImagePickerUseCase imagePickerUseCase;
  AdminProductBloc({
    required this.repository,
    required this.imagePickerUseCase,
  }) : super(const _AdminAddProductState()) {
    on(_onInitial);
    on(_onSelectCategory);
    on(_onPickerImage);
    add(const AdminProductInitialEvent());
  }
}

extension AdminProductBlocExtension on AdminProductBloc {
  Future<void> _onInitial(AdminProductInitialEvent event,
      Emitter<AdminProductState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    final caregories = await repository.getCategories();
    emitter(state.copyWith(isLoading: false, categories: caregories));
  }

  Future<void> _onSelectCategory(AdminOnSelectCategoryEvent event,
      Emitter<AdminProductState> emitter) async {
    emitter(state.copyWith(idCate: event.idCate));
  }

  Future<void> _onPickerImage(
      AdminOnPickImageEvent event, Emitter<AdminProductState> emitter) async {
    final dataImage = await imagePickerUseCase();
    emitter(state.copyWith(imageFile: dataImage));
  }
}
