import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/features/user/splash/presentations/bloc/splash_bloc.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: _buildSplash(),
        );
      },
    );
  }

  Widget _buildSplash() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: AppColor.primaryColor,
      child: Text(
        'nikeyboots'.toUpperCase(),
        style: AppStyle.regula28.copyWith(color: AppColor.whiteColor),
      ),
    );
  }
}
