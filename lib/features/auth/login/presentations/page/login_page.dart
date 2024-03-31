import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/auth/login/presentations/binding/splash_binding.dart';
import 'package:nike_shoe_shop/features/auth/login/presentations/widgets/login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: LoginBingding.generateBloc,
      child: LoginWidget(),
    );
  }
}
