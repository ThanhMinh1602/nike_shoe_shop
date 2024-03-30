import 'package:cloud_firestore/cloud_firestore.dart';
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
  AdCategoryWidget({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Category list',
                  style:
                      AppStyle.regular20.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.greyColor),
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    separatorBuilder: (_, __) => const Divider(
                      indent: 0,
                      endIndent: 0,
                    ),
                    itemBuilder: (context, index) {
                      return _buildCategoryListItem(
                        context,
                        state.categories[index],
                        index,
                      );
                    },
                  ),
                ),
                const Spacer(),
                SizedBox(height: 10.h),
                AppButton(
                  buttonText: 'Add new category',
                  minimumSize: Size(double.infinity, 30.0.h),
                  boderRadius: 10.0,
                  onPressed: () {
                    _showAddNewCategoryDialog(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryListItem(
      BuildContext context, CategoryModel category, int index) {
    return GestureDetector(
      onTap: () => _showUpdateCategoryDialog(context, category),
      child: ListTile(
        leading: Text('${index + 1}', style: AppStyle.regular12),
        title: Row(
          children: [
            Image.network(
              category.image,
              width: 30.0.w,
            ),
            SizedBox(width: 20.0.w),
            Expanded(
              child: Text(
                category.name!.toUpperCase(),
                style: AppStyle.regular12,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete_outline,
            color: AppColor.redColor,
          ),
          onPressed: () => _showDeleteCategoryDialog(context, category),
        ),
      ),
    );
  }

  void _showAddNewCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return _buildFormDialog(context, isNewCategory: true);
      },
    );
  }

  void _showUpdateCategoryDialog(BuildContext context, CategoryModel category) {
    showDialog(
      context: context,
      builder: (_) {
        return _buildFormDialog(context,
            isNewCategory: false, category: category);
      },
    );
  }

  void _showDeleteCategoryDialog(BuildContext context, CategoryModel category) {
    AppDiaLog.showAwesomeConfirmDialog(
      context,
      content: 'Do you want to delete this category?',
      btnOkOnPress: () {
        context.getBloc<AdCategoryBloc>().add(AdDeleteCategoryEvent(category.id!));
      },
    );
  }

  Widget _buildFormDialog(BuildContext context,
      {bool isNewCategory = true, CategoryModel? category}) {
    _nameController.text = isNewCategory ? '' : category!.name!;
    return BlocProvider.value(
      value: BlocProvider.of<AdCategoryBloc>(context),
      child: BlocBuilder<AdCategoryBloc, AdCategoryState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
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
                            .read<AdCategoryBloc>()
                            .add(const AdImagePickerEvent()),
                        child: state.imageFile != null
                            ? Image.file(
                                state.imageFile!,
                              )
                            : Icon(
                                Icons.add_a_photo_outlined,
                                size: 100.w,
                              ),
                      ),
                      SizedBox(height: 10.0.h),
                      if (state.imageFile == null)
                        Text(
                          'Please upload an image file!',
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
                        ),
                      ),
                      SizedBox(height: 5.0.h),
                      AppTextField(
                        controller: _nameController,
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
                            isNewCategory
                                ? context.read<AdCategoryBloc>().add(
                                      AdAddNewCategoryEvent(
                                        CategoryModel(
                                          id: '',
                                          name: _nameController.text,
                                          image: state.imageFile,
                                          createAt: Timestamp.now(),
                                        ),
                                      ),
                                    )
                                : context.read<AdCategoryBloc>().add(
                                      AdUpdateCategoryEvent(
                                        CategoryModel(
                                          id: category!.id,
                                          name: _nameController.text,
                                          image: state.imageFile,
                                          createAt: category.createAt,
                                        ),
                                      ),
                                    );
                            _nameController.clear();
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
