import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/auth/recovery_password/presentations/binding/recovery_password_binding.dart';
import 'package:nike_shoe_shop/features/auth/recovery_password/presentations/widgets/recovery_password_widget.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: RecoveryPasswordBinding.generateBloc,
      child: RecoveryPasswordWidget(),
    );
  }
}
