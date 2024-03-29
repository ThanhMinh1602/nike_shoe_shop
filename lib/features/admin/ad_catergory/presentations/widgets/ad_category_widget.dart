import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/components/dialog/app_dialog.dart';
import 'package:nike_shoe_shop/common/components/textfields/app_text_field.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_catergory/presentations/bloc/ad_category_bloc.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

class AdCategoryWidget extends StatelessWidget {
  AdCategoryWidget({super.key});

  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category manager'),
        backgroundColor: AppColor.primaryColor,
      ),
      body: BlocConsumer<AdCategoryBloc, AdCategoryState>(
        listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.show();
          } else {
            EasyLoading.dismiss();
          }
          if (state.addNewCategorySuccess) {
            AppDiaLog.showAwesomeDialog(
              context,
              content: 'Add category success',
              btnOkOnPress: () => context.getNavigator().pop(),
            );
            nameController.clear();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
              top: 20.0,
            ),
            child: Column(
              children: [
                AppButton(
                  buttonText: 'Add new category',
                  minimumSize: Size(100.0.h, 30.0.h),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return _formAddNewProduct(context);
                      },
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _formAddNewProduct(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AdCategoryBloc>(context),
      child: BlocBuilder<AdCategoryBloc, AdCategoryState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20.0.h),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () => context
                            .getBloc<AdCategoryBloc>()
                            .add(const AdImagePickerEventEvent()),
                        child: state.imageFile == null
                            ? Icon(
                                Icons.add_a_photo_outlined,
                                size: 100.w,
                              )
                            : Image.file(
                                state.imageFile!,
                              ),
                      ),
                      SizedBox(height: 10.0.h),
                      if (state.imageFile == null)
                        Text(
                          'Plese upload image file!',
                          textAlign: TextAlign.center,
                          style: AppStyle.adminLight10.copyWith(
                            color: AppColor.redColor,
                          ),
                        ),
                      SizedBox(height: 20.0.h),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Product name',
                            style: AppStyle.regular12,
                          )),
                      SizedBox(height: 5.0.h),
                      AppTextField(
                        controller: nameController,
                        hintText: 'Enter your product name',
                        fillColor: AppColor.greyColor300,
                        validator: Validator.checkIsEmpty,
                        boderRadius: 10.0,
                      ),
                      SizedBox(height: 20.0.h),
                      AppButton(
                        boderRadius: 10.0,
                        buttonText: 'Submit',
                        minimumSize: Size(double.infinity, 50.0.h),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              state.imageFile != null) {
                            context.getBloc<AdCategoryBloc>().add(
                                  AdAddNewCategoryEvent(
                                    CategoryModel(
                                        id: '',
                                        name: nameController.text,
                                        image: state.imageFile),
                                  ),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
