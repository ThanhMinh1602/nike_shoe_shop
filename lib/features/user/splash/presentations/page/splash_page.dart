import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/features/user/splash/presentations/binding/splash_binding.dart';
import 'package:nike_shoe_shop/features/user/splash/presentations/widgets/splash_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvider(
      create: SplashBinding.generateBloc,
      child: SplashWidget(),
    );
  }
}
