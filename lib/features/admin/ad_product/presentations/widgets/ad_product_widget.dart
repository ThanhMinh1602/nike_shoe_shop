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
import 'package:nike_shoe_shop/entities/models/requests/add_product_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/presentations/bloc/ad_product_bloc.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

// ignore: must_be_immutable
class AdProductWidget extends StatelessWidget {
  AdProductWidget({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController minSizeController = TextEditingController();
  final TextEditingController maxSizeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        backgroundColor: AppColor.primaryColor,
      ),
      body: BlocConsumer<AdProductBloc, AdProductState>(
        listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.show();
          } else {
            EasyLoading.dismiss();
          }
          if (state.addNewProductSuccess) {
            AppDiaLog.showAwesomeDialog(
              context,
              content: 'Add product success',
              btnOkOnPress: () => context.getNavigator().pop(),
            );
            nameController.clear();
            descriptionController.clear();
            maxSizeController.clear();
            minSizeController.clear();
            quantityController.clear();
            priceController.clear();
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
                  buttonText: 'Add new product',
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
      value: BlocProvider.of<AdProductBloc>(context),
      child: BlocBuilder<AdProductBloc, AdProductState>(
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
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () => context
                            .getBloc<AdProductBloc>()
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
                        boderRadius: 10.0,
                      ),
                      SizedBox(height: 20.0.h),
                      Row(
                        children: [
                          _buildInputNumber(
                            controller: priceController,
                            title: 'Price',
                            hintText: 'Enter your price',
                          ),
                          SizedBox(width: 20.w),
                          _buildInputNumber(
                            controller: quantityController,
                            title: 'Quantity',
                            hintText: 'Enter your quantity',
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0.h),
                      Text('Size', style: AppStyle.regular12),
                      SizedBox(height: 10.0.h),
                      Row(
                        children: [
                          _buildSizeInput(
                            controller: minSizeController,
                            hintText: 'Min size',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Icon(Icons.arrow_right_alt_rounded),
                          ),
                          _buildSizeInput(
                            controller: maxSizeController,
                            hintText: 'Max size',
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0.h),
                      Text('Category', style: AppStyle.regular12),
                      SizedBox(height: 10.0.h),
                      Expanded(
                        child: Container(
                          height: 53.0,
                          decoration: BoxDecoration(
                            color: AppColor.greyColor300,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButton<CategoryModel>(
                            elevation: 16,
                            value: state.categoryModel,
                            onChanged: (value) {
                              context
                                  .getBloc<AdProductBloc>()
                                  .add(AdOnSelectCategoryEvent(value!));
                            },
                            items: state.categories.map((category) {
                              return DropdownMenuItem<CategoryModel>(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: AppStyle.regular12
                                      .copyWith(color: AppColor.adminTextColor),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Text('Description', style: AppStyle.regular12),
                      SizedBox(height: 10.0.h),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0.r),
                          border: Border.all(color: AppColor.greyColor),
                        ),
                        child: EditableText(
                          controller: descriptionController,
                          focusNode: FocusNode(),
                          style: AppStyle.regular12
                              .copyWith(color: AppColor.textColor),
                          cursorColor: AppColor.primaryColor,
                          maxLines: 5,
                          backgroundCursorColor: AppColor.primaryColor,
                          keyboardType: TextInputType.multiline,
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      AppButton(
                        boderRadius: 10.0,
                        buttonText: 'Submit',
                        minimumSize: Size(double.infinity, 50.0.h),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              state.imageFile != null) {
                            context.getBloc<AdProductBloc>().add(
                                  AdAddNewProductEvent(
                                    AddProductModel(
                                        productName: nameController.text,
                                        price: double.parse(
                                            priceController.text.trim()),
                                        quantity: int.parse(
                                            quantityController.text.trim()),
                                        minSize:
                                            int.parse(minSizeController.text),
                                        maxSize:
                                            int.parse(maxSizeController.text),
                                        cateId: state.categoryModel!.id,
                                        cateName: state.categoryModel!.name,
                                        desctiption: descriptionController.text,
                                        image: state.imageFile!),
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

  Expanded _buildSizeInput(
      {TextEditingController? controller, String? hintText}) {
    return Expanded(
      child: AppTextField(
        keyboardType: TextInputType.number,
        controller: controller,
        isInputSize: true,
        boderRadius: 10.0.r,
        fillColor: AppColor.greyColor300,
        hintText: hintText,
        validator: Validator.checkIsEmpty,
      ),
    );
  }

  Widget _buildInputNumber(
      {String? title, String? hintText, TextEditingController? controller}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title ?? '', style: AppStyle.regular12),
          SizedBox(height: 10.0.h),
          AppTextField(
            keyboardType: TextInputType.number,
            isInputSize: true,
            controller: controller,
            boderRadius: 10.0.r,
            fillColor: AppColor.greyColor300,
            hintText: hintText,
            validator: Validator.checkNumber,
          ),
        ],
      ),
    );
  }
}
