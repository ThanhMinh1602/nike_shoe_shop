import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';

// ignore: must_be_immutable
class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  AppBarCustom({
    super.key,
    this.title,
  });
  final String? title;
  String location = 'Mondolibug, Sylhet';
  @override
  Widget build(BuildContext context) {
    AppNavigator navigator = context.getNavigator();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0)
          .copyWith(top: MediaQuery.of(context).padding.top + 8.0.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (title == location) {
                Scaffold.of(context).openDrawer();
              } else {
                navigator.pop();
              }
            },
            child: CircleAvatar(
              radius: 22.0.r,
              backgroundColor: AppColor.whiteColor,
              child: Icon(
                  title == location
                      ? Icons.grid_view_rounded
                      : Icons.arrow_back_rounded,
                  color: AppColor.textColor,
                  size: 20.0.r),
            ),
          ),
          const Spacer(),
          if (title == location)
            Icon(Icons.location_on_sharp,
                color: AppColor.redColor, size: 12.0.r),
          const SizedBox(width: 4.0),
          Text(
            title ?? '',
            style: AppStyle.loginSubTitle,
          ),
          const Spacer(),
          (title == location || title == 'Men’s Shoes')
              ? Stack(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          navigator.push(screen: const ScreenType.cart()),
                      child: CircleAvatar(
                        radius: 22.0.r,
                        backgroundColor: AppColor.whiteColor,
                        child: Icon(
                          Icons.shopping_bag_rounded,
                          color: AppColor.textColor,
                          size: 15.0.r,
                        ),
                      ),
                    ),
                    Positioned(
                        right: 2.w,
                        top: 3.h,
                        child: CircleAvatar(
                          radius: 4.0.r,
                          backgroundColor: AppColor.redColor,
                        ))
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(44.h);
}
