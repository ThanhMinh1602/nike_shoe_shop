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
import 'package:nike_shoe_shop/entities/models/requests/signup_request.dart';
import 'package:nike_shoe_shop/features/user/auth/signup/presentations/bloc/signup_bloc.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

class SignUpWidget extends StatelessWidget {
  SignUpWidget({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state.isLoading) {
              EasyLoading.show(status: 'loading...');
            } else {
              EasyLoading.dismiss();
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                    top: MediaQuery.of(context).padding.top + 84.h,
                    bottom: 20.h),
                children: [
                  Center(
                      child: Text('Create Account',
                          style: AppStyle.loginTitle
                              .copyWith(fontWeight: FontWeight.bold))),
                  Center(
                    child: Text('Let’s Create Account Together',
                        style: AppStyle.loginSubTitle
                            .copyWith(color: Colors.grey[600])),
                  ),
                  SizedBox(height: 50.h),
                  Text('Your Name', style: TextStyle(fontSize: 10.sp)),
                  const SizedBox(height: 12.0),
                  _buildNameInput(),
                  SizedBox(height: 20.0.h),
                  Text('Email address', style: TextStyle(fontSize: 10.sp)),
                  const SizedBox(height: 12.0),
                  _buildEmailInput(),
                  SizedBox(height: 20.0.h),
                  Text('Password', style: TextStyle(fontSize: 10.sp)),
                  const SizedBox(height: 12.0),
                  _buildPasswordInput(),
                  SizedBox(height: 20.0.h),
                  Text('Confirm Password', style: TextStyle(fontSize: 13.sp)),
                  const SizedBox(height: 12.0),
                  _buildPasswordConfirmInput(),
                  SizedBox(height: 20.0.h),
                  _buildButtonSigUp(context),
                  SizedBox(height: 40.0.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Already have an account?',
                            style: AppStyle.regular10
                                .copyWith(color: Colors.grey[400])),
                        TextSpan(
                            text: 'Sign in',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context
                                    .getBloc<SignUpBloc>()
                                    .add(const OnTapToLoginEvent());
                              },
                            style: AppStyle.regular10.copyWith(
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  AppTextFieldPassword _buildPasswordInput() {
    return AppTextFieldPassword(
      validator: Validator.checkPassword,
      controller: _passwordController,
      hintText: 'Enter your password',
    );
  }

  AppTextFieldPassword _buildPasswordConfirmInput() {
    return AppTextFieldPassword(
      validator: (value) =>
          Validator.confirmPassword(value, _passwordController.text.trim()),
      controller: _passwordConfirmController,
      hintText: 'Confirm your password',
    );
  }

  AppTextField _buildEmailInput() {
    return AppTextField(
      validator: Validator.checkEmail,
      controller: _emailController,
      hintText: 'Enter your email',
    );
  }

  AppTextField _buildNameInput() {
    return AppTextField(
      validator: Validator.checkIsEmpty,
      controller: _nameController,
      hintText: 'Enter your name',
    );
  }

  Widget _buildButtonSigUp(BuildContext context) {
    return AppButton(
      buttonText: 'Sign Up',
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.getBloc<SignUpBloc>().add(OnTapSignUpEvent(SignupRequest(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text)));
        }
      },
    );
  }
}
