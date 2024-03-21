import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0)
          .copyWith(top: MediaQuery.of(context).padding.top + 8.0.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.0.r,
            backgroundColor: AppColor.whiteColor,
            child: Icon(Icons.grid_view_rounded,
                color: AppColor.textColor, size: 15.0.r),
          ),
          const Spacer(),
          Icon(Icons.location_on_sharp, color: AppColor.redColor, size: 12.0.r),
          const SizedBox(width: 4.0),
          Text(
            'Mondolibug, Sylhet',
            style: AppStyle.loginSubTitle,
          ),
          const Spacer(),
          Stack(
            children: [
              CircleAvatar(
                radius: 22.0.r,
                backgroundColor: AppColor.whiteColor,
                child: Icon(
                  Icons.shopping_bag_rounded,
                  color: AppColor.textColor,
                  size: 15.0.r,
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
