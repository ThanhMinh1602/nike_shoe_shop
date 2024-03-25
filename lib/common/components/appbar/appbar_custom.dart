import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String location = 'Mondolibug, Sylhet';

  const AppBarCustom({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
        top: MediaQuery.of(context).padding.top + 8.0.h,
        bottom: 8.0.h,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _handleAppBarTap(context),
            child: CircleAvatar(
              radius: 22.0.r,
              backgroundColor: AppColor.whiteColor,
              child: Icon(
                title == location
                    ? Icons.grid_view_rounded
                    : Icons.arrow_back_rounded,
                color: AppColor.textColor,
                size: 20.0.r,
              ),
            ),
          ),
          const Spacer(),
          _buildLocationIcon(),
          SizedBox(width: title == location ? 4.0 : 0),
          Text(
            title ?? '',
            style: AppStyle.loginSubTitle,
          ),
          const Spacer(),
          _buildShoppingCartIcon(context),
        ],
      ),
    );
  }

  void _handleAppBarTap(BuildContext context) {
    if (title == location) {
      Scaffold.of(context).openDrawer();
    } else {
      context.getNavigator().pop();
    }
  }

  Widget _buildLocationIcon() {
    return title == location
        ? Icon(
            Icons.location_on_sharp,
            color: AppColor.redColor,
            size: 12.0.r,
          )
        : const SizedBox();
  }

  Widget _buildShoppingCartIcon(BuildContext context) {
    return (title == location || title == 'Men’s Shoes')
        ? Stack(
            children: [
              GestureDetector(
                onTap: () => context
                    .getNavigator()
                    .push(screen: const ScreenType.cart()),
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
                ),
              ),
            ],
          )
        : SizedBox(width: 44.0.r);
  }

  @override
  Size get preferredSize => Size.fromHeight(54.h);
}
