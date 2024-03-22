import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/product_detail/presentations/bloc/product_detail_bloc.dart';

class ProductDetailWidget extends StatelessWidget {
  final ProductModel productModel;
  const ProductDetailWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBarCustom(
        leftIcon: Icons.arrow_back_ios_rounded,
        onTapLeft: () =>
            context.getBloc<ProductDetailBloc>().add(const OnTapBackEvent()),
      ),
      bottomNavigationBar: Container(
        height: 94.0.h,
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24.0.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('price',
                    style: AppStyle.regular12
                        .copyWith(color: AppColor.subTextColor)),
                SizedBox(height: 8.0.h),
                Text('\$${productModel.price}',
                    style: AppStyle.regular14
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            AppButton(
              buttonText: 'Add To Cart',
              onPressed: () {},
            )
          ],
        ),
      ),
      body: BlocConsumer<ProductDetailBloc, ProductDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.only(top: 16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0)
                    .copyWith(bottom: 16.0),
                child: Image.network(
                  productModel.image,
                  fit: BoxFit.fitHeight,
                  width: double.infinity,
                  height: 202,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
