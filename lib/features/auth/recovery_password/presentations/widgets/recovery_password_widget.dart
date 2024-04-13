import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/components/textfields/app_text_field.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/auth/recovery_password/presentations/bloc/recovery_password_bloc.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

class RecoveryPasswordWidget extends StatefulWidget {
  RecoveryPasswordWidget({super.key});

  @override
  State<RecoveryPasswordWidget> createState() => _RecoveryPasswordWidgetState();
}

class _RecoveryPasswordWidgetState extends State<RecoveryPasswordWidget> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onTapRecoveryPassword() {
    if (_formKey.currentState!.validate()) {
      context
          .getBloc<RecoveryPasswordBloc>()
          .add(RecoveryPasswordResetPasswordEvent(_emailController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: const AppBarCustom(
          title: '',
        ),
        body: BlocListener<RecoveryPasswordBloc, RecoveryPasswordState>(
          listener: (context, state) {
            if (state.isLoading) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
          },
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0)
                .copyWith(top: 32.0),
            children: [
              Text('Recovery Password',
                  textAlign: TextAlign.center, style: AppStyle.loginTitle),
              SizedBox(height: 4.0.h),
              Text(
                'Please Enter Your Email Address To Recieve a Verification',
                textAlign: TextAlign.center,
                style: AppStyle.loginSubTitle,
              ),
              SizedBox(height: 50.0.h),
              Text('Email address', style: TextStyle(fontSize: 10.sp)),
              const SizedBox(height: 12.0),
              AppTextField(
                validator: Validator.checkEmail,
                controller: _emailController,
                hintText: 'Enter your email',
              ),
              SizedBox(height: 40.0.h),
              AppButton(
                buttonText: 'Continue',
                onPressed: onTapRecoveryPassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}
