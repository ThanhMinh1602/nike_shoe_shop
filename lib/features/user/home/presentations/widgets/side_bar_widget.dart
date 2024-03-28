import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/components/dialog/app_dialog.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/features/user/home/presentations/bloc/home_bloc.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Drawer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0)
                  .copyWith(top: 60.h),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 32.h,
                    backgroundImage:
                        NetworkImage(state.userModel?.avatar ?? ''),
                  ),
                  SizedBox(height: 24.h),
                  Text('Hey, 👋',
                      style: AppStyle.regular14.copyWith(color: Colors.grey)),
                  SizedBox(height: 6.h),
                  Text(state.userModel?.name ?? '',
                      textAlign: TextAlign.center,
                      style: AppStyle.regular20
                          .copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 50.0.h),
                  _buildSideBarItem(
                    label: 'Profile',
                    icon: Icons.person_outline_rounded,
                    onTap: () => context
                        .getNavigator()
                        .push(screen: ScreenType.profile(state.userModel!)),
                  ),
                  SizedBox(height: 30.0.h),
                  _buildSideBarItem(
                      label: 'Home Page',
                      icon: Icons.home_outlined,
                      onTap: () => context.getNavigator().pop()),
                  SizedBox(height: 30.0.h),
                  _buildSideBarItem(
                    label: 'My Cart',
                    icon: Icons.shopping_bag_outlined,
                    onTap: () => context
                        .getNavigator()
                        .push(screen: const ScreenType.cart()),
                  ),
                  SizedBox(height: 30.0.h),
                  _buildSideBarItem(
                    label: 'Favorive',
                    icon: Icons.favorite_outline,
                  ),
                  SizedBox(height: 30.0.h),
                  _buildSideBarItem(
                    label: 'Order',
                    icon: Icons.local_shipping_outlined,
                    onTap: () => context
                        .getNavigator()
                        .push(screen: const ScreenType.order()),
                  ),
                  SizedBox(height: 30.0.h),
                  _buildSideBarItem(
                    label: 'Notifications',
                    icon: Icons.notifications_outlined,
                  ),
                  SizedBox(height: 30.0.h),
                  const Divider(),
                  SizedBox(height: 30.0.h),
                  _buildSideBarItem(
                      label: 'Sign Out',
                      icon: Icons.logout_rounded,
                      onTap: () {
                        AppDiaLog.showAwesomeDialog(
                          context,
                          content: 'Are you sure you want to log out?',
                          btnOkOnPress: () => context
                              .getBloc<HomeBloc>()
                              .add(const OnTapLogOutEvent()),
                        );
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSideBarItem(
      {required IconData icon, required String label, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 24.0.h),
          const SizedBox(width: 24.0),
          Text(label,
              style: AppStyle.regular12.copyWith(fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
