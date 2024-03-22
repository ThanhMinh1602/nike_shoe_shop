import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/entities/models/appmodels/category_model.dart';
import 'package:nike_shoe_shop/features/home/presentations/bloc/home_bloc.dart';

class HomeWiget extends StatefulWidget {
  const HomeWiget({super.key});

  @override
  State<HomeWiget> createState() => _HomeWigetState();
}

class _HomeWigetState extends State<HomeWiget> {
  @override
  void initState() {
    super.initState();
    context.getBloc<HomeBloc>().add(const HomeInitialEvent());
  }

  final paddingHori = const EdgeInsets.symmetric(horizontal: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: const AppBarCustom(
          leftIcon: Icons.grid_view_rounded,
          title: 'Mondolibug, Sylhet',
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.isLoading) {
              EasyLoading.show(status: 'loading...');
            } else {
              EasyLoading.dismiss();
            }
          },
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
              children: [
                _buildSearchBar(),
                const SizedBox(height: 32.0),
                _buildCategories(),
                const SizedBox(height: 24.0),
                _buildPopularShoes(state),
                const SizedBox(height: 24.0),
                _buildNewArrival(state),
              ],
            );
          },
        ));
  }

  Widget _buildPopularShoes(HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Popular Shoes', style: AppStyle.regular14),
              GestureDetector(
                onTap: () {
                  context
                      .getBloc<HomeBloc>()
                      .add(const HomeLoadMorePopularEvent());
                },
                child: Text('See all',
                    style: AppStyle.regular10
                        .copyWith(color: AppColor.primaryColor)),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.isLoadMorePopular == true
                ? state.bestSalerProducts.length
                : 2,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 21.w,
              crossAxisCount: 2,
              mainAxisSpacing: 21.w,
              mainAxisExtent: 212.h,
            ),
            itemBuilder: (context, index) {
              final product = state.bestSalerProducts[index];
              return _buildPopolarItem(
                image: product.image,
                title: 'Best Seller',
                name: product.name,
                price: product.price.toString(),
                onTapAddToCart: () {},
                onTapDetail: () {
                  context
                      .getBloc<HomeBloc>()
                      .add(OnTapToDetailProductEvent(product));
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildNewArrival(HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Arrivals', style: AppStyle.regular14),
              GestureDetector(
                onTap: () {
                  context
                      .getBloc<HomeBloc>()
                      .add(const HomeLoadMoreNewArrivalEvent());
                },
                child: Text('See all',
                    style: AppStyle.regular10
                        .copyWith(color: AppColor.primaryColor)),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.isLoadMoreNewArrival == true
                ? state.newProducts.length
                : 2,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 21.w,
              crossAxisCount: 2,
              mainAxisSpacing: 21.w,
              mainAxisExtent: 212.h,
            ),
            itemBuilder: (context, index) {
              final product = state.newProducts[index];
              return _buildPopolarItem(
                image: product.image,
                title: 'Best Choice',
                name: product.name,
                price: product.price.toString(),
                onTapAddToCart: () {},
                onTapDetail: () {
                  context
                      .getBloc<HomeBloc>()
                      .add(OnTapToDetailProductEvent(product));
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildPopolarItem({
    String? image,
    String? title,
    String? name,
    String? price,
    void Function()? onTapAddToCart,
    void Function()? onTapDetail,
  }) {
    return GestureDetector(
      onTap: onTapDetail,
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(16.0.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    image ??
                        'https://static.thenounproject.com/png/741653-200.png',
                    height: 97.h,
                    width: double.infinity,
                  ),
                  SizedBox(height: 12.0.h),
                  Text(title?.toUpperCase() ?? '--:--',
                      style: AppStyle.regular12
                          .copyWith(color: AppColor.primaryColor)),
                  SizedBox(height: 4.0.h),
                  Text(
                    name ?? '--:--',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.regular14.copyWith(
                        color: AppColor.textColor, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12.0.h),
                  Text(
                    '\$${price ?? '--:--'}',
                    style: AppStyle.regular14.copyWith(
                        color: AppColor.textColor, fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onTapAddToCart,
              child: Container(
                  width: 34.w,
                  height: 35.5.h,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16.0.r),
                      topLeft: Radius.circular(16.0.r),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColor.whiteColor,
                    size: 12.w,
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 44.0.w,
      child: ListView.separated(
        padding: paddingHori,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16.0),
        itemBuilder: (context, index) {
          return CircleAvatar(
            radius: 22.0.w,
            backgroundColor: AppColor.whiteColor,
            child: Padding(
              padding: EdgeInsets.all(6.0.w),
              child: SvgPicture.asset(
                categories[index].image,
                width: 26.0.w,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: paddingHori,
      child: SearchBar(
        hintText: 'Looking for shoes',
        hintStyle: MaterialStatePropertyAll(
            AppStyle.regular10.copyWith(color: AppColor.subTextColor)),
        backgroundColor: const MaterialStatePropertyAll(AppColor.whiteColor),
        leading: const Icon(Icons.search, color: AppColor.subTextColor),
        elevation: const MaterialStatePropertyAll(0),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 8.0,
          ),
        ),
      ),
    );
  }
}
