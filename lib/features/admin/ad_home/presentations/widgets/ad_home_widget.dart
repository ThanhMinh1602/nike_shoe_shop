import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';

class AdHomeWidget extends StatefulWidget {
  const AdHomeWidget({Key? key})
      : super(key: key); // Sửa const thành constructor

  @override
  State<AdHomeWidget> createState() => _AdHomeWidgetState();
}

class _AdHomeWidgetState extends State<AdHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      body: GridView(
        padding: EdgeInsets.all(20.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0.h,
          mainAxisSpacing: 20.0.h,
        ),
        children: [
          _buildGridItem(
            title: 'Product',
            total: '100',
            onTap: () {
              context
                  .getNavigator()
                  .push(screen: const ScreenType.adminProduct());
            },
          ),
          _buildGridItem(
            title: 'Category',
            total: '100',
            onTap: () {
              context
                  .getNavigator()
                  .push(screen: const ScreenType.adminCategory());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem({
    String? title,
    String? total,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0.h),
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(10.0.r),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: AppColor.greyColor,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? '',
              style:
                  AppStyle.adminSemibold14.copyWith(color: AppColor.whiteColor),
            ),
            SizedBox(height: 10.h),
            Text(
              'Total: $total',
              style: AppStyle.adminLight10.copyWith(color: AppColor.whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
