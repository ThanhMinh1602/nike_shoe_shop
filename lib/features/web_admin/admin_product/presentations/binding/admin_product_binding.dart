import 'package:flutter/cupertino.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/data/admin_product_impl.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/domain/usecase/ImagePickerUseCase.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/presentations/bloc/admin_product_bloc.dart';

class AdminProductBinding {
  static AdminProductBloc generateBloc(BuildContext context) {
    return AdminProductBloc(
      repository: AdminProductRepositoryImpl(),
      imagePickerUseCase: ImagePickerUseCase(),
    );
  }
}
