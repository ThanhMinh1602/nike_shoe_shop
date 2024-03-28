import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/components/textfields/app_text_field.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/presentations/bloc/admin_product_bloc.dart';
import 'package:nike_shoe_shop/gen/assets.gen.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

// ignore: must_be_immutable
class AdminProductWidget extends StatelessWidget {
  AdminProductWidget({super.key});

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController minSizeController = TextEditingController();
  final TextEditingController maxSizeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminProductBloc, AdminProductState>(
      listener: (context, state) {
        if (state.isLoading) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20.0.h),
          margin: EdgeInsets.all(20.0.h),
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10.0.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton(
                buttonText: 'Add product',
                boderRadius: 5.0,
                minimumSize: Size(100.w, 50.0.h),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => _buildFormAddProduct(context),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFormAddProduct(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AdminProductBloc>(context),
      child: BlocBuilder<AdminProductBloc, AdminProductState>(
        builder: (context, state) {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => context.getNavigator().pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Text('Add new product', style: AppStyle.adminMedium16),
                  SizedBox(height: 50.0.h),
                  // Form fields
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left side: Product details
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product name field
                            Text('Product name', style: AppStyle.adminLight14),
                            SizedBox(height: 10.0.h),
                            AppTextField(
                              controller: nameController,
                              boderRadius: 10.0.r,
                              fillColor: AppColor.greyColor300,
                              hintText: 'Enter your product name',
                              validator: Validator.checkIsEmpty,
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
                            Row(children: [
                              Expanded(
                                child:
                                    Text('Size', style: AppStyle.adminLight14),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: Text('Category',
                                    style: AppStyle.adminLight14),
                              )
                            ]),
                            SizedBox(height: 10.0.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      _buildSizeInput(
                                        controller: minSizeController,
                                        hintText: 'Min size',
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child:
                                            Icon(Icons.arrow_right_alt_rounded),
                                      ),
                                      _buildSizeInput(
                                        controller: maxSizeController,
                                        hintText: 'Max size',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: Container(
                                    height: 53.0.h,
                                    decoration: BoxDecoration(
                                      color: AppColor.greyColor300,
                                      borderRadius:
                                          BorderRadius.circular(10.0.r),
                                    ),
                                    child: DropdownButton<String>(
                                      elevation: 16,
                                      value: state.idCate.toString(),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.0.w),
                                      icon: Container(),
                                      underline: Container(),
                                      onChanged: (value) {
                                        context.getBloc<AdminProductBloc>().add(
                                              AdminOnSelectCategoryEvent(
                                                  int.parse(value!)),
                                            );
                                      },
                                      items: state.categories.map((category) {
                                        return DropdownMenuItem<String>(
                                          value: category.id.toString(),
                                          child: Text(
                                            category.name.toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: AppStyle.regular12.copyWith(
                                                color: AppColor.adminTextColor),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0.h),
                            Text('Description', style: AppStyle.adminLight14),
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
                          ],
                        ),
                      ),
                      SizedBox(width: 50.w),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => context
                                  .getBloc<AdminProductBloc>()
                                  .add(const AdminOnPickImageEvent()),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0.r),
                                child: state.imageFile != null
                                    ? Image.memory(state.imageFile!)
                                    : Image.network(
                                        'https://static.thenounproject.com/png/396915-200.png'),
                              ),
                            ),
                            SizedBox(height: 75.h),
                            AppButton(
                              boderRadius: 10.0,
                              buttonText: 'Submit',
                              minimumSize: Size(double.infinity, 50.0.h),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Build a text field for size input
  Expanded _buildSizeInput(
      {TextEditingController? controller, String? hintText}) {
    return Expanded(
      child: AppTextField(
        controller: controller,
        isInputSize: true,
        boderRadius: 10.0.r,
        fillColor: AppColor.greyColor300,
        hintText: hintText,
        validator: Validator.checkIsEmpty,
      ),
    );
  }

  // Build a text field for numeric input
  Widget _buildInputNumber(
      {String? title, String? hintText, TextEditingController? controller}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title ?? '', style: AppStyle.adminLight14),
          SizedBox(height: 10.0.h),
          AppTextField(
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
