import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
    this.title,
    this.onTapLeft,
    this.onTapRight,
    this.leftIcon,
  });
  final String? title;
  final void Function()? onTapLeft;
  final void Function()? onTapRight;
  final IconData? leftIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0)
          .copyWith(top: MediaQuery.of(context).padding.top + 8.0.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTapLeft,
            child: CircleAvatar(
              radius: 22.0.r,
              backgroundColor: AppColor.whiteColor,
              child: Icon(leftIcon, color: AppColor.textColor, size: 15.0.r),
            ),
          ),
          const Spacer(),
          if (title != null)
            Icon(Icons.location_on_sharp,
                color: AppColor.redColor, size: 12.0.r),
          const SizedBox(width: 4.0),
          Text(
            title ?? '',
            style: AppStyle.loginSubTitle,
          ),
          const Spacer(),
          Stack(
            children: [
              GestureDetector(
                onTap: onTapRight,
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
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(44.h);
}
