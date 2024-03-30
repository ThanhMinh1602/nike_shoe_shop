import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/components/dialog/app_dialog.dart';
import 'package:nike_shoe_shop/common/components/textfields/app_text_field.dart';
import 'package:nike_shoe_shop/common/components/textfields/app_text_field_password.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';
import 'package:nike_shoe_shop/features/user/profile/presentations/bloc/profile_bloc.dart';
import 'package:nike_shoe_shop/gen/assets.gen.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key, required this.userModel}) : super(key: key);
  final UserModel userModel;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fullNameController.text = widget.userModel.name ?? '';
    _emailController.text = widget.userModel.email ?? '';
    _passwordController.text = widget.userModel.password ?? '';
    context.getBloc<ProfileBloc>().add(const ProfileInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const AppBarCustom(title: 'Profile'),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.updateProfileSuccess) {
            AppDiaLog.showAwesomeSuccessDialog(
              context,
              btnOkOnPress: () {
                context.getNavigator().pushAndRemoveUntil(
                      screen: const ScreenType.home(),
                    );
              },
              content: 'Update information successfully',
            );
          }
          if (state.isLoading) {
            EasyLoading.show();
          } else {
            EasyLoading.dismiss();
          }
        },
        builder: (context, state) {
          return _buildProfileBody(state);
        },
      ),
    );
  }

  Widget _buildProfileBody(ProfileState state) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(15.0.h),
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0.h),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: state.imageFile != null
                        ? CircleAvatar(
                            radius: 50.h,
                            backgroundImage:
                                FileImage(state.imageFile!))
                        : state.userModel?.avatar == null
                            ? CircleAvatar(
                                radius: 50.h,
                                backgroundImage:
                                    AssetImage(Assets.images.imageError.path))
                            : CircleAvatar(
                                radius: 50.h,
                                backgroundImage: NetworkImage(
                                    state.userModel?.avatar ?? '')),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: GestureDetector(
                      onTap: () async {
                        context
                            .getBloc<ProfileBloc>()
                            .add(const OnTapPickImageEvent());
                      },
                      child: const Icon(
                        Icons.add_a_photo,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0.h),
            Text(
              widget.userModel.name ?? '',
              textAlign: TextAlign.center,
              style: AppStyle.regular20.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32.0.h),
            _buildTextField(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              controller: _fullNameController,
              validator: Validator.checkIsEmpty,
            ),
            _buildTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              controller: _emailController,
              readOnly: true,
            ),
            const SizedBox(height: 12.0),
            Text(
              'Pasword',
              style: AppStyle.regular14.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12.0),
            AppTextFieldPassword(
              fillColor: AppColor.greyColor300,
              hintText: 'Enter your password',
              validator: Validator.checkPassword,
              controller: _passwordController,
            ),
            const SizedBox(height: 50.0),
            AppButton(
              buttonText: 'Submit',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<ProfileBloc>().add(
                        OnTapUpDateProfileEvent(
                          UserModel(
                            avatar: state.userModel!.avatar,
                            name: _fullNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text.trim(),
                          ),
                          state.imageFile ?? File(''),
                        ),
                      );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppStyle.regular14.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12.0),
        AppTextField(
          fillColor: AppColor.greyColor300,
          hintText: hintText,
          validator: validator,
          controller: controller,
          readOnly: readOnly,
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
