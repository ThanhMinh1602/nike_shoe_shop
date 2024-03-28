import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_category.dart/presentations/page/admin_category_page.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_dashboard/presentations/bloc/admin_dashboard_bloc.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/presentations/page/admin_product_page.dart';

class AdminDashboardWidget extends StatelessWidget {
  const AdminDashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sideBarTitles = [
      'Home',
      'Products',
      'Categorys',
      'Payments',
      'User',
    ];
    final List<Widget> pages = [
      Container(),
      const AdminAddProductPage(),
      const AdminCategoryPage(),
      const AdminAddProductPage(),
      const AdminAddProductPage(),
    ];
    return Scaffold(
      backgroundColor: AppColor.adminBackgroundColor,
      body: BlocConsumer<AdminDashboardBloc, AdminDashboardState>(
        listener: (context, state) {
          if (state.isLoading) {
            EasyLoading.show();
          } else {
            EasyLoading.dismiss();
          }
        },
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: AppColor.adminTextColor,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            'NIKE SHOE SHOP',
                            style: AppStyle.adminMedium16
                                .copyWith(color: AppColor.adminBackgroundColor),
                          ),
                        ),
                      ),
                      const Divider(height: 0),
                      Expanded(
                        flex: 10,
                        child: ListView.builder(
                          itemCount: sideBarTitles.length,
                          itemBuilder: (context, index) {
                            final isActive = state.pageIndex == index;
                            return _buildSideBarItem(
                              backgroundColor: isActive
                                  ? AppColor.adminBackgroundColor
                                  : AppColor.adminTextColor,
                              textColor: isActive
                                  ? AppColor.adminTextColor
                                  : AppColor.adminBackgroundColor,
                              label: sideBarTitles[index],
                              onTap: () => context
                                  .getBloc<AdminDashboardBloc>()
                                  .add(AdminDashBoardChangePageEvent(index)),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(color: AppColor.whiteColor),
                    ),
                    Expanded(
                      flex: 10,
                      child: IndexedStack(
                        index: state.pageIndex,
                        children: List.generate(
                          pages.length,
                          (_) => pages[state.pageIndex],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSideBarItem({
    required VoidCallback onTap,
    required String label,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.0.h),
        color: backgroundColor,
        child: Row(
          children: [
            Icon(Icons.dashboard_outlined, color: textColor, size: 18),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                label,
                style: AppStyle.adminMedium14.copyWith(color: textColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
