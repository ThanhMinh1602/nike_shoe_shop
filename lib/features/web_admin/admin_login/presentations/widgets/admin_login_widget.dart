import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/components/textfields/app_text_field.dart';
import 'package:nike_shoe_shop/common/components/textfields/app_text_field_password.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/entities/models/requests/login_request.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_login/presentations/bloc/admin_login_bloc.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

class AdminLoginWidget extends StatelessWidget {
  const AdminLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColor.adminBackgroundColor,
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            width: 900.w,
            height: 564.h,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10.0.r),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 0,
                    color: AppColor.blackColor.withOpacity(0.25))
              ],
            ),
            child: Row(
              children: [
                Expanded(
                    child: ClipRRect(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(10.0.r)),
                  child: Image.network(
                      'https://cdn.pixabay.com/photo/2024/02/25/13/30/shoes-8595773_1280.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover),
                )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(40.0.h),
                  child: ListView(
                    children: [
                      Text('Login', style: AppStyle.adminSemibold22),
                      Text('Nike shoe shop admin',
                          style: AppStyle.adminLight16),
                      SizedBox(height: 40.0.h),
                      Text('E-Mail', style: AppStyle.adminLight14),
                      SizedBox(height: 5.0.h),
                      AppTextField(
                        controller: _emailController,
                        fillColor: AppColor.greyColor300,
                        boderRadius: 5.0,
                        hintText: 'Enter your Email',
                        validator: Validator.checkIsEmpty,
                      ),
                      SizedBox(height: 20.0.h),
                      Text('Password', style: AppStyle.adminLight14),
                      SizedBox(height: 5.0.h),
                      AppTextFieldPassword(
                        controller: _passwordController,
                        fillColor: AppColor.greyColor300,
                        boderRadius: 5.0,
                        hintText: 'Enter your password',
                        validator: Validator.checkIsEmpty,
                      ),
                      SizedBox(height: 61.h),
                      Expanded(
                        child: AppButton(
                          boderRadius: 5.0.r,
                          buttonText: 'Login',
                          minimumSize: Size.fromHeight(60.0.h),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.getBloc<AdminLoginBloc>().add(
                                    AdminLoginEvents(
                                      LoginRequest(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    ),
                                  );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
