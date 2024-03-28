import 'package:flutter/widgets.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_login/data/admin_login_repositpry_impl.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_login/presentations/bloc/admin_login_bloc.dart';

class AdminLoginBinding {
  static AdminLoginBloc generateBloc(BuildContext context) {
    return AdminLoginBloc(
      repository: AdminLoginRepositoryImpl(),
      appNavigator: context.getNavigator(),
    );
  }
}
