import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/requests/payment_model.dart';
import 'package:nike_shoe_shop/features/user/checkout/presentations/bloc/checkout_bloc.dart';
import 'package:nike_shoe_shop/services/local/share_pref.dart';
import 'package:nike_shoe_shop/utils/validator.dart';

class CheckoutWidget extends StatefulWidget {
  const CheckoutWidget({
    super.key,
    required this.totalProduct,
    required this.totalPrice,
  });
  final int totalProduct;
  final double totalPrice;
  @override
  State<CheckoutWidget> createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  @override
  void initState() {
    super.initState();
    context.getBloc<CheckoutBloc>().add(const CheckoutInitialEvent());
  }

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: const AppBarCustom(title: 'Checkout'),
        body: _buildPaymentBody());
  }

  Widget _buildPaymentBody() {
    return BlocConsumer<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state.isLoading) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }
        if (state.paymentSuccess) {
          AwesomeDialog(
            context: context,
            animType: AnimType.leftSlide,
            dismissOnTouchOutside: false,
            dialogBorderRadius: BorderRadius.circular(20.0.r),
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.w),
            headerAnimationLoop: true,
            dialogType: DialogType.success,
            showCloseIcon: false,
            desc: 'Your Payment Is Successful',
            descTextStyle: AppStyle.regular20,
            btnOk: AppButton(
              buttonText: 'Back To Shopping',
              onPressed: () {
                context
                    .getNavigator()
                    .pushAndRemoveUntil(screen: const ScreenType.home());
              },
            ),
          ).show();
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPaymentContent(state),
              _buildTotalPrice(
                  totalPrice: widget.totalPrice.toString(),
                  totalProduct: widget.totalProduct.toString(),
                  onTapCheckout: () {
                    if (_formKey.currentState!.validate()) {
                      context.getBloc<CheckoutBloc>().add(
                            OnTapPaymentEvent(
                              PaymentModel(
                                uId: SharedPrefs.token,
                                customerName: _nameController.text,
                                email: _emailController.text,
                                phoneNumber: _phoneNumberController.text,
                                address: _addressController.text,
                                note: _noteController.text,
                                cartData: state.listCart,
                                totalPrice: widget.totalPrice,
                                totalProduct: widget.totalProduct,
                                paymentMethod: 'Thanh toán khi nhận hàng',
                                paymentStatus: false,
                                createdAt: DateTime.now(),
                              ),
                            ),
                          );
                    }
                  }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPaymentContent(CheckoutState state) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20.0)
            .copyWith(top: 24.0, bottom: 13.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
        decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(16.0.r)),
        child: ListView(
          children: [
            Text('Order Information', style: AppStyle.regular14),
            ...List.generate(state.listCart.length, (index) {
              final product = state.listCart[index];
              return _buildOderItem(
                  name: product.productName,
                  pathImage: product.productImage,
                  price: product.productPrice.toString(),
                  size: product.size.toString(),
                  quantity: product.quantity.toString());
            }),
            const Divider(),
            const SizedBox(height: 10),
            Text('Contact Information', style: AppStyle.regular14),
            _buildContactItem(
              controller: _nameController,
              validator: Validator.checkIsEmpty,
              icon: Icons.person_outline_rounded,
              label: 'Name',
              onPressedEdit: () {},
            ),
            _buildContactItem(
              controller: _emailController,
              validator: Validator.checkEmail,
              icon: Icons.email_outlined,
              label: 'Email',
              onPressedEdit: () {},
            ),
            SizedBox(height: 10.0.h),
            _buildContactItem(
              controller: _phoneNumberController,
              validator: Validator.checkPhoneNumber,
              icon: Icons.phone_outlined,
              label: 'Phone Number',
              onPressedEdit: () {},
            ),
            SizedBox(height: 10.0.h),
            _buildContactItem(
                controller: _addressController,
                label: 'Address',
                validator: Validator.checkIsEmpty,
                icon: Icons.location_on_outlined,
                onPressedEdit: () {}),
            SizedBox(height: 10.0.h),
            _buildContactItem(
                controller: _noteController,
                label: 'Note',
                icon: Icons.edit_note_sharp,
                onPressedEdit: () {})
          ],
        ),
      ),
    );
  }

  Widget _buildOderItem({
    String? name,
    String? price,
    String? size,
    String? pathImage,
    String? quantity,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            height: 45.0.w,
            width: 45.0.w,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12.0.r),
              image: DecorationImage(
                image: NetworkImage(pathImage ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.0.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name ?? '', style: AppStyle.regular8),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$ $price, Size: $size',
                        style: AppStyle.regular8
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text('X $quantity',
                        style: AppStyle.regular8
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
      {required IconData icon,
      required TextEditingController controller,
      required String label,
      required void Function()? onPressedEdit,
      String? Function(String?)? validator}) {
    const address = 'Note';
    return Row(
      crossAxisAlignment: label == address
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(10.0.h),
          margin: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              color: AppColor.greyColor300,
              borderRadius: BorderRadius.circular(12.0.r)),
          child: Icon(
            icon,
            size: 20.0,
          ),
        ),
        label == address
            ? Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0.r),
                      border: Border.all(
                        color: AppColor.greyColor,
                      )),
                  child: Column(
                    children: [
                      EditableText(
                        controller: controller,
                        focusNode: FocusNode(),
                        style: AppStyle.regular12
                            .copyWith(color: AppColor.textColor),
                        cursorColor: AppColor.primaryColor,
                        maxLines: 5,
                        backgroundCursorColor: AppColor.primaryColor,
                        keyboardType: TextInputType.multiline,
                      ),
                    ],
                  ),
                ),
              )
            : Expanded(
                child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: label == 'Phone Number'
                    ? TextInputType.phone
                    : label == 'Email'
                        ? TextInputType.emailAddress
                        : label == 'Name'
                            ? TextInputType.name
                            : TextInputType.streetAddress,
                validator: validator,
                style: AppStyle.regular12,
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    label: Text(label,
                        style: AppStyle.regular12
                            .copyWith(color: AppColor.subTextColor))),
              )),
      ],
    );
  }

  Widget _buildTotalPrice({
    String? totalPrice,
    String? totalProduct,
    void Function()? onTapCheckout,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0.h),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.0.r)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Price', style: AppStyle.nameProductStyle),
              Text('\$ ${totalPrice ?? 0}', style: AppStyle.nameProductStyle),
            ],
          ),
          SizedBox(height: 20.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Product', style: AppStyle.regular12),
              Text(totalProduct ?? '0', style: AppStyle.regular12),
            ],
          ),
          SizedBox(height: 20.0.h),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              buttonText: 'Checkout',
              onPressed: onTapCheckout,
            ),
          )
        ],
      ),
    );
  }
}
