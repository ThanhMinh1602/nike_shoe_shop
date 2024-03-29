import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/data/product_repository_impl.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/domain/usecase/ad_image_picker_usecase.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/presentations/bloc/ad_product_bloc.dart';

class AdProductBinding {
  static AdProductBloc generateBloc(BuildContext context) {
    return AdProductBloc(
        adImagePickerUseCase: AdImagePickerUseCase(),
        repository: ProductRepositoryImpl(),
        appNavigator: context.getNavigator());
  }
}
