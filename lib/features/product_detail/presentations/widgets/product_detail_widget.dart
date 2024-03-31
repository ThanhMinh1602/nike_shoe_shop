import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';
import 'package:nike_shoe_shop/common/components/buttons/app_button.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/product_detail/presentations/bloc/product_detail_bloc.dart';

class ProductDetailWidget extends StatefulWidget {
  final ProductModel product;
  const ProductDetailWidget({super.key, required this.product});

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  @override
  void initState() {
    context
        .getBloc<ProductDetailBloc>()
        .add(ProductDetailInitialEvent(widget.product));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: _buildProductDetailAppBar(context),
      body: _buildProductDetailBody(),
    );
  }

  AppBarCustom _buildProductDetailAppBar(BuildContext context) {
    return const AppBarCustom(title: 'Men’s Shoes');
  }

  Widget _buildProductDetailBody() {
    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            _buildProductImage(),
            _buildProductDetails(state),
            _buildBottomBar(state),
          ],
        );
      },
    );
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.0.r),
        child: Image.network(
          widget.product.image,
          fit: BoxFit.fitHeight,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildProductDetails(ProductDetailState state) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w).copyWith(top: 16.0.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0.r)),
        ),
        child: ListView(
          children: [
            _buildProductTitle(),
            const SizedBox(height: 12.0),
            _buildProductPrice(),
            const SizedBox(height: 8.0),
            _buildProductDescription(),
            const SizedBox(height: 16.0),
            _buildProductGallery(),
            const SizedBox(height: 16.0),
            _buildProductSizes(state),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BEST SALE',
          style: AppStyle.regular12.copyWith(color: AppColor.primaryColor),
        ),
        const SizedBox(height: 6.0),
        Text(widget.product.name, style: AppStyle.bold16),
      ],
    );
  }

  Widget _buildProductPrice() {
    return Text('\$${widget.product.price}',
        style: AppStyle.regular14.copyWith(fontWeight: FontWeight.w700));
  }

  Widget _buildProductDescription() {
    return Text(
      widget.product.description,
      style: AppStyle.regular12.copyWith(color: AppColor.subTextColor),
    );
  }

  Widget _buildProductGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gallery',
            style: AppStyle.regular14.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16.0),
        Row(
          children: List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(right: 16.0.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0.r),
                child: Image.network(
                  'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_'
                  'product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl'
                  '_relative,w_1.0,h_1.0,fl_layer_apply/ff5e9061-0c6d-4dfd-87fc'
                  '-344cf839291f/jordan-stadium-90-shoes-Jn6ZH4.png',
                  fit: BoxFit.cover,
                  height: 56.h,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductSizes(ProductDetailState state) {
    final size = widget.product.sizes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size',
            style: AppStyle.regular14.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 32.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: size.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => context
                    .getBloc<ProductDetailBloc>()
                    .add(OnTapSelectSizeEvent(widget.product.sizes[index])),
                child: CircleAvatar(
                  radius: 16.0.w,
                  backgroundColor: state.selectedSize == size[index]
                      ? AppColor.primaryColor
                      : AppColor.backgroundColor,
                  child: Text(
                    widget.product.sizes[index].toString(),
                    style: AppStyle.regular10.copyWith(
                      color: state.selectedSize == size[index]
                          ? Colors.white
                          : AppColor.subTextColor,
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildBottomBar(ProductDetailState state) {
    return Container(
      height: 94.0.h,
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0.r)),
      ),
      child: Row(
        children: [
          _buildPriceSection(),
          Expanded(
            child: AppButton(
              buttonText: 'Add To Cart',
              onPressed: () {
                context.getBloc<ProductDetailBloc>().add(
                      OnTapAddProductToCartEvent(
                        CartModel(
                            productId: widget.product.id,
                            productName: widget.product.name,
                            productImage: widget.product.image,
                            productPrice: widget.product.price,
                            quantity: 1,
                            size: state.selectedSize ??
                                widget.product.sizes.first),
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Price',
              style: AppStyle.regular12.copyWith(color: AppColor.subTextColor)),
          SizedBox(height: 8.0.h),
          Text('\$${widget.product.price}',
              style: AppStyle.regular14.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
