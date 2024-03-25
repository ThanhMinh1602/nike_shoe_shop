import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/cart/presentations/bloc/cart_bloc.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  void initState() {
    super.initState();
    context.getBloc<CartBloc>().add(const CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: const AppBarCustom(
        title: 'My Cart',
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.show();
          } else {
            EasyLoading.dismiss();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: _buildListCart(state),
              ),
              _buildTotalPrice(
                onTapCheckout: () {},
              ),
            ],
          );
        },
      ),
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

  Widget _buildListCart(CartState state) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      itemCount: state.listCart.length,
      separatorBuilder: (context, index) => const SizedBox(height: 30.0),
      itemBuilder: (context, index) {
        final cartProduct = state.listCart[index];
        return _buildCartItem(
          onRemoveProduct: () => context
              .getBloc<CartBloc>()
              .add(RemoveProductFromCartEvent(cartProduct.id!)),
          maxVal: 100,
          minVal: 1,
          initVal: num.parse(cartProduct.quantity.toString()),
          name: cartProduct.productName,
          pathImage: cartProduct.productImage,
          price: cartProduct.productPrice.toString(),
          size: cartProduct.size.toString(),
        );
      },
    );
  }

  Widget _buildCartItem(
      {String? name,
      String? price,
      String? size,
      String? pathImage,
      num? maxVal,
      num? minVal,
      num? initVal,
      required void Function()? onRemoveProduct,
      void Function(dynamic)? onQtyChanged}) {
    return Row(
      children: [
        Container(
          height: 85.0.w,
          width: 85.0.w,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(22.0.r),
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
              Text(name ?? '', style: AppStyle.nameProductStyle),
              SizedBox(height: 10.0.h),
              Text('\$ $price', style: AppStyle.nameProductStyle),
              SizedBox(height: 15.0.h),
              InputQty(
                maxVal: maxVal ?? 0,
                minVal: minVal ?? 0,
                initVal: initVal ?? 0,
                onQtyChanged: onQtyChanged,
                decoration: const QtyDecorationProps(
                    borderShape: BorderShapeBtn.circle,
                    border: InputBorder.none,
                    btnColor: AppColor.primaryColor),
              ),
            ],
          ),
        ),
        SizedBox(width: 16.0.w),
        Column(
          children: [
            Text(size ?? '',
                style:
                    AppStyle.regular12.copyWith(fontWeight: FontWeight.w700)),
            SizedBox(height: 20.0.h),
            IconButton(
                onPressed: onRemoveProduct,
                icon: const Icon(Icons.delete_outline_rounded,
                    color: AppColor.redColor))
          ],
        )
      ],
    );
  }
}
