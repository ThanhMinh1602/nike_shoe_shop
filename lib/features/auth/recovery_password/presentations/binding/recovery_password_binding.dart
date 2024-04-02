import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/auth/recovery_password/data/recovery_repository_impl.dart';
import 'package:nike_shoe_shop/features/auth/recovery_password/presentations/bloc/recovery_password_bloc.dart';

class RecoveryPasswordBinding {
  static RecoveryPasswordBloc generateBloc(BuildContext context) {
    return RecoveryPasswordBloc(
      repository: RecoveryRepositoryImpl(),
      appNavigator: context.getNavigator(),
    );
  }
}
