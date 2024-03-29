import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/features/admin/ad_catergory/data/ad_category_repository_inpl.dart';
import 'package:nike_shoe_shop/features/admin/ad_catergory/presentations/bloc/ad_category_bloc.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/domain/usecase/ad_image_picker_usecase.dart';

class AdCategoryBinding {
  static AdCategoryBloc generateBloc(BuildContext context) {
    return AdCategoryBloc(
      adImagePickerUseCase: AdImagePickerUseCase(),
      repository: AdCategoryRepositoryImpl(),
    );
  }
}
