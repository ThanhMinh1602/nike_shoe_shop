import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/user/auth/signup/presentations/binding/splash_binding.dart';
import 'package:nike_shoe_shop/features/user/auth/signup/presentations/widgets/signup_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: SignUpBingding.generateBloc,
      child: SignUpWidget(),
    );
  }
}
