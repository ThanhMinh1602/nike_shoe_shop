import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_shoe_shop/common/components/appbar/appbar_custom.dart';
import 'package:nike_shoe_shop/common/constants/app_color.dart';
import 'package:nike_shoe_shop/common/constants/app_style.dart';
import 'package:nike_shoe_shop/common/extensions/build_context_extension.dart';
import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/promotion_model.dart';
import 'package:nike_shoe_shop/features/home/presentations/bloc/home_bloc.dart';
import 'package:nike_shoe_shop/gen/assets.gen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _promotionController = PageController();
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeInitialEvent());
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_promotionController.hasClients) {
        _promotionController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void _onTapAddProductToCart(ProductModel product, BuildContext context) {
    context.getBloc<HomeBloc>().add(OnTapAddProductToCart(CartModel(
          productId: product.id,
          quantity: 1,
          size: product.sizes.first,
          productName: product.name,
          productImage: product.image,
          productPrice: product.price,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        appBar: _buildAppBar(),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  context.getBloc<HomeBloc>().add(const OnTapLogOutEvent());
                },
                child: const Row(
                  children: [Icon(Icons.logout_sharp), Text('Logout')],
                ),
              )
            ],
          ),
        ),
        body: _buildHomeBody(),
      ),
    );
  }

  AppBarCustom _buildAppBar() {
    return const AppBarCustom(
      title: 'Mondolibug, Sylhet',
    );
  }

  BlocConsumer<HomeBloc, HomeState> _buildHomeBody() {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
          children: [
            _buildSearchBar(),
            _searchController.text.isEmpty
                ? _buildHomeContent(state)
                : state.searchProductsResult.isEmpty
                    ? _buildSearchEmpty()
                    : _buildSearchResult(state),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SearchBar(
        controller: _searchController,
        onChanged: (value) =>
            context.read<HomeBloc>().add(OnTapSearchProductEvent(value)),
        hintText: 'Looking for shoes',
        hintStyle: MaterialStateProperty.all(
          AppStyle.regular10.copyWith(color: AppColor.subTextColor),
        ),
        backgroundColor: MaterialStateProperty.all(AppColor.whiteColor),
        leading: const Icon(Icons.search, color: AppColor.subTextColor),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
        ),
      ),
    );
  }

  Widget _buildHomeContent(HomeState state) {
    if (state.bestSalerProducts.isEmpty ||
        state.categories.isEmpty ||
        state.newProduct == null) {
      return _buildLoadingShimmer(state);
    }
    return Column(
      children: [
        const SizedBox(height: 10.0),
        _buildPromotion(),
        const SizedBox(height: 24.0),
        _buildCategories(state),
        const SizedBox(height: 24.0),
        _buildPopularShoes(state),
        const SizedBox(height: 24.0),
        _buildNewArrival(state),
      ],
    );
  }

  Widget _buildLoadingShimmer(HomeState state) {
    return Center(
      child: Shimmer(
        gradient: LinearGradient(colors: [
          AppColor.whiteColor,
          AppColor.primaryColor.withOpacity(0.2),
          AppColor.whiteColor,
        ]),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            _buildPromotion(),
            const SizedBox(height: 24.0),
            _buildCategories(state),
            const SizedBox(height: 24.0),
            _buildPopularShoes(state),
            const SizedBox(height: 24.0),
            _buildNewArrival(state),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildListPromotion(),
        const SizedBox(height: 10.0),
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildPageIndicator() {
    return Center(
      child: SmoothPageIndicator(
        effect: ExpandingDotsEffect(
          dotColor: AppColor.greyColor,
          activeDotColor: AppColor.primaryColor,
          dotHeight: 2.0.h,
          dotWidth: 12.0,
          spacing: 4.0.w,
        ),
        controller: _promotionController,
        count: 5,
      ),
    );
  }

  Widget _buildListPromotion() {
    return SizedBox(
      height: 109.33.h,
      width: double.infinity,
      child: PageView.builder(
        controller: _promotionController,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0.r),
              child: Image.network(
                promotions[index].path,
                fit: BoxFit.cover,
                width: 328.w,
                height: 109.33.h,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategories(HomeState state) {
    return SizedBox(
      height: 44.0.w,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        scrollDirection: Axis.horizontal,
        itemCount: state.categories.length,
        itemBuilder: (context, index) {
          final isSelected = state.selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(OnTapCategoryEvent(index));
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 16.0),
              padding: EdgeInsets.symmetric(
                vertical: isSelected ? 6.0.w : 0,
              ).copyWith(right: isSelected ? 16.0.w : 0),
              height: 44.h,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primaryColor
                    : AppColor.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(40.0.r),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22.0.w,
                    backgroundColor: AppColor.whiteColor,
                    child: Padding(
                      padding: EdgeInsets.all(6.0.w),
                      child: SvgPicture.asset(
                        state.categories[index].image,
                        width: isSelected ? 20.0.w : 26.0.w,
                        // ignore: deprecated_member_use
                        color: AppColor.blackColor,
                      ),
                    ),
                  ),
                  if (isSelected) SizedBox(width: 3.0.w),
                  if (isSelected)
                    Text(
                      state.categories[index].name.toUpperCase(),
                      style: AppStyle.categoryStyle.copyWith(
                        color: AppColor.whiteColor,
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchEmpty() {
    return Padding(
      padding: EdgeInsets.only(top: 200.h),
      child: Column(
        children: [
          Image.asset(Assets.images.nothingFound.path),
          const SizedBox(height: 16.0),
          Text(
            'No result found',
            style: AppStyle.regular14.copyWith(color: AppColor.textColor),
          )
        ],
      ),
    );
  }

  Widget _buildSearchResult(HomeState state) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 32.0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.searchProductsResult.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 21.w,
        crossAxisCount: 2,
        mainAxisSpacing: 21.w,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final product = state.searchProductsResult[index];
        return _buildPopolarItem(
          image: product.image,
          title: product.orderCount > 500 ? 'Best Seller' : '',
          name: product.name,
          price: product.price.toString(),
          onTapAddToCart: () => _onTapAddProductToCart(product, context),
          onTapDetail: () {
            context.read<HomeBloc>().add(OnTapToDetailProductEvent(product));
          },
        );
      },
    );
  }

  Widget _buildPopolarItem({
    String? image,
    String? title,
    String? name,
    String? price,
    VoidCallback? onTapAddToCart,
    VoidCallback? onTapDetail,
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
                Text(
                  title?.toUpperCase() ?? '--:--',
                  style:
                      AppStyle.regular12.copyWith(color: AppColor.primaryColor),
                ),
                SizedBox(height: 4.0.h),
                Text(name ?? '--:--',
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.nameProductStyle),
                SizedBox(height: 12.0.h),
                Text(
                  '\$$price',
                  style: AppStyle.regular14.copyWith(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                      .read<HomeBloc>()
                      .add(const HomeLoadMorePopularEvent());
                },
                child: Text('See all',
                    style: AppStyle.regular10
                        .copyWith(color: AppColor.primaryColor)),
              ),
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
                childAspectRatio: 0.65),
            itemBuilder: (context, index) {
              final product = state.bestSalerProducts[index];
              return _buildPopolarItem(
                image: product.image,
                title: 'Best Seller',
                name: product.name,
                price: product.price.toString(),
                onTapAddToCart: () => _onTapAddProductToCart(product, context),
                onTapDetail: () {
                  context
                      .read<HomeBloc>()
                      .add(OnTapToDetailProductEvent(product));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNewArrival(HomeState state) {
    return GestureDetector(
      onTap: () => context
          .read<HomeBloc>()
          .add(OnTapToDetailProductEvent(state.newProduct!)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Arrivals', style: AppStyle.regular14),
            const SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(20.0.w),
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(16.0.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BEST CHOICE',
                          style: AppStyle.regular12
                              .copyWith(color: AppColor.primaryColor),
                        ),
                        SizedBox(height: 4.0.h),
                        Text(state.newProduct?.name ?? '',
                            style: AppStyle.bold16),
                        SizedBox(height: 10.0.h),
                        Text('\$${state.newProduct?.price}',
                            style: AppStyle.regular14
                                .copyWith(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Image.network(
                    state.newProduct?.image ?? '',
                    height: 100.0.h,
                    width: 100.0.h,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
