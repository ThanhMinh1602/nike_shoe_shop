import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/user/order/presentations/bloc/order_bloc.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  void initState() {
    super.initState();
    context.getBloc<OrderBloc>().add(const OrderInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: const AppBarCustom(
          title: 'Order',
        ),
        body: BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state.isLoading) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
          },
          builder: (context, state) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: state.orderList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16.0),
              itemBuilder: (context, index) {
                final dataOrder = state.orderList[index];
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Order ${index + 1}',
                        style: AppStyle.regular12,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataOrder.cartData.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10.0),
                        itemBuilder: (_, indexItem) {
                          final cartItemData = dataOrder.cartData[indexItem];
                          return _buildOderItem(
                              name: cartItemData.productName,
                              pathImage: cartItemData.productImage,
                              price: cartItemData.productPrice.toString(),
                              quantity: cartItemData.quantity.toString(),
                              size: cartItemData.size.toString());
                        },
                      ),
                      const SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Order date: ',
                                  style: AppStyle.regular8.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.blackColor)),
                              TextSpan(
                                  text: DateFormat('HH:mm:ss - dd/MM/yyyy')
                                      .format(dataOrder.createdAt ??
                                          DateTime.now()),
                                  style: AppStyle.regular8
                                      .copyWith(color: AppColor.greyColor))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Status: ',
                                  style: AppStyle.regular8.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.blackColor)),
                              TextSpan(
                                  text: 'Delivering',
                                  style: AppStyle.regular8
                                      .copyWith(color: AppColor.greyColor))
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 300.0,
                      //   child: Timeline.custom(
                      //     scrollDirection: Axis.horizontal,
                      //     childrenDelegate: TimelineTileBuilderDelegate(
                      //         childCount: 3, (context, index) {
                      //       List<IconData> icons = [
                      //         Icons.inventory_2_outlined,
                      //         Icons.local_shipping_outlined,
                      //         Icons.check_circle_outline_outlined,
                      //       ];
                      //       return Icon(icons[index]);
                      //     }),
                      //   ),
                      // )
                    ],
                  ),
                );
              },
            );
          },
        ));
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
                Text(name ?? '', style: AppStyle.regular10),
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
}
