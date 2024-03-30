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
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/presentations/bloc/ad_product_bloc.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

class AdProductWidget extends StatelessWidget {
  AdProductWidget({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _minSizeController = TextEditingController();
  final TextEditingController _maxSizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _showDeleteProductDialog(BuildContext context, String productId) {
    AppDiaLog.showAwesomeConfirmDialog(
      context,
      content: 'Do you want to delete this product?',
      btnOkOnPress: () {
        context.getBloc<AdProductBloc>().add(AdDeleteProductEvent(productId));
      },
    );
  }

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
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Product list',
                  style:
                      AppStyle.regular20.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: state.products.length,
                      separatorBuilder: (_, __) =>
                          const Divider(indent: 0, endIndent: 0),
                      itemBuilder: (context, index) {
                        return _buildProductListItem(
                            context, state.products[index], index);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                AppButton(
                  buttonText: 'Add new product',
                  minimumSize: Size(double.infinity, 30.0.h),
                  boderRadius: 10.0,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return _formAddNewProduct(context);
                      },
                    );
                    _nameController.clear();
                    _descriptionController.clear();
                    _maxSizeController.clear();
                    _minSizeController.clear();
                    _quantityController.clear();
                    _priceController.clear();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductListItem(
      BuildContext context, ProductModel product, int index) {
    return GestureDetector(
      onTap: () => _formAddNewProduct(context),
      child: ListTile(
        leading: Text('${index + 1}', style: AppStyle.regular12),
        title: Row(
          children: [
            Image.network(
              product.image,
              width: 30.0,
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Text(
                product.name.toUpperCase(),
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
          onPressed: () => _showDeleteProductDialog(context, product.id),
        ),
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
                  padding: const EdgeInsets.all(20.0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () => context
                            .getBloc<AdProductBloc>()
                            .add(const AdImagePickerEventEvent()),
                        child: state.imageFileUpload == null
                            ? const Icon(
                                Icons.add_a_photo_outlined,
                                size: 100.0,
                              )
                            : Image.file(
                                state.imageFileUpload!,
                              ),
                      ),
                      const SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Product name',
                          style: AppStyle.regular12,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      AppTextField(
                        controller: _nameController,
                        hintText: 'Enter your product name',
                        fillColor: AppColor.greyColor300,
                        boderRadius: 10.0,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          _buildInputNumber(
                            title: 'Price',
                            hintText: 'Enter your price',
                            controller: _priceController,
                          ),
                          const SizedBox(width: 20.0),
                          _buildInputNumber(
                            title: 'Quantity',
                            hintText: 'Enter your quantity',
                            controller: _quantityController,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Text('Size', style: AppStyle.regular12),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          _buildSizeInput(
                              controller: _minSizeController,
                              hintText: 'Min size'),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Icon(Icons.arrow_right_alt_rounded),
                          ),
                          _buildSizeInput(
                              controller: _maxSizeController,
                              hintText: 'Max size'),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Text('Category', style: AppStyle.regular12),
                      const SizedBox(height: 10.0),
                      Expanded(
                        child: Container(
                          height: 53.0,
                          decoration: BoxDecoration(
                            color: AppColor.greyColor300,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: DropdownButton<CategoryModel>(
                            elevation: 16,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            icon: const SizedBox(),
                            underline: const SizedBox(),
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
                                  category.name!.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: AppStyle.regular12
                                      .copyWith(color: AppColor.adminTextColor),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text('Description', style: AppStyle.regular12),
                      const SizedBox(height: 10.0),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: AppColor.greyColor),
                        ),
                        child: TextFormField(
                          controller: _descriptionController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      AppButton(
                        boderRadius: 10.0,
                        buttonText: 'Submit',
                        minimumSize: const Size(double.infinity, 50.0),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              state.imageFileUpload != null) {
                            context.getBloc<AdProductBloc>().add(
                                  AdAddNewProductEvent(
                                    AddProductModel(
                                      productName: _nameController.text,
                                      price: double.parse(
                                          _priceController.text.trim()),
                                      quantity: int.parse(
                                          _quantityController.text.trim()),
                                      minSize:
                                          int.parse(_minSizeController.text),
                                      maxSize:
                                          int.parse(_maxSizeController.text),
                                      cateId: state.categoryModel!.id!,
                                      cateName: state.categoryModel!.name!,
                                      desctiption: _descriptionController.text,
                                      image: state.imageFileUpload!,
                                    ),
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
        boderRadius: 10.0,
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
          const SizedBox(height: 10.0),
          AppTextField(
            keyboardType: TextInputType.number,
            isInputSize: true,
            controller: controller,
            boderRadius: 10.0,
            fillColor: AppColor.greyColor300,
            hintText: hintText,
            validator: Validator.checkNumber,
          ),
        ],
      ),
    );
  }
}
