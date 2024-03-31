import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/components/textfields/app_text_field.dart';
import 'package:nike_shoe_shop/common/components/textfields/app_text_field_password.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/entities/models/requests/login_request.dart';
import 'package:nike_shoe_shop/features/auth/login/presentations/bloc/login_bloc.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.show(status: 'loading...');
          } else {
            EasyLoading.dismiss();
          }
        }, builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                  top: MediaQuery.of(context).padding.top + 84.h, bottom: 20.h),
              children: [
                Center(child: Text('Hello Again!', style: AppStyle.loginTitle)),
                Center(
                  child: Text('Welcome Back You’ve Been Missed!',
                      style: AppStyle.loginSubTitle
                          .copyWith(color: Colors.grey[600])),
                ),
                SizedBox(height: 50.h),
                Text('Email address', style: TextStyle(fontSize: 10.sp)),
                const SizedBox(height: 12.0),
                _buildEmailInput(),
                SizedBox(height: 20.0.h),
                Text('Password', style: TextStyle(fontSize: 10.sp)),
                const SizedBox(height: 12.0),
                _buildPasswordInput(),
                const SizedBox(height: 12.0),
                Text(
                  'Recovery Password',
                  textAlign: TextAlign.end,
                  style: AppStyle.regular10,
                ),
                const SizedBox(height: 30.0),
                _buildLoginButton(context),
                SizedBox(height: 230.0.h),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Don’t have an account?',
                          style: AppStyle.regular10
                              .copyWith(color: Colors.grey[400])),
                      _buildPushToSignUp(context),
                    ]))
              ],
            ),
          );
        }),
      ),
    );
  }

  AppButton _buildLoginButton(BuildContext context) {
    return AppButton(
      buttonText: 'Login',
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.getBloc<LoginBloc>().add(
                OnTapLoginEvent(
                  LoginRequest(
                      email: _emailController.text,
                      password: _passwordController.text),
                ),
              );
        }
      },
    );
  }

  TextSpan _buildPushToSignUp(BuildContext context) {
    return TextSpan(
        text: 'Sign Up for free',
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            context.getBloc<LoginBloc>().add(const OnTapToSignUpEvent());
          },
        style: AppStyle.regular10
            .copyWith(color: AppColor.blackColor, fontWeight: FontWeight.bold));
  }

  AppTextField _buildEmailInput() {
    return AppTextField(
      validator: Validator.checkIsEmpty,
      controller: _emailController,
      hintText: 'Enter your email',
    );
  }

  AppTextFieldPassword _buildPasswordInput() {
    return AppTextFieldPassword(
      validator: Validator.checkIsEmpty,
      controller: _passwordController,
      hintText: 'Enter your password',
    );
  }
}
