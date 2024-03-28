import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:nike_shoe_shop/entities/models/requests/user_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/user/home/data/home_repository_impl.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppNavigator appNavigator;
  final HomeRepositoryImpl repository;

  HomeBloc({
    required this.appNavigator,
    required this.repository,
  }) : super(const HomeInitialState()) {
    on(_onInit);
    on(_onLoadMorePopular);
    on(_onCategoryTap);
    on(_onTapProductDetail);
    on(_onTapSearchProduct);
    on(_onTapLogOut);
    on(_onAddToCart);
  }

  Future<void> _onInit(
      HomeInitialEvent event, Emitter<HomeState> emitter) async {
    emitter(const HomeInitialState(isLoading: true));
    final categories = await repository.allCategories();
    final bestSalerProducts = await repository.bestSalerProductByCategoryId(0);
    final newProduct = await repository.newProductByCategoryId(0);
    final user = await repository.userData();

    emitter(state.copyWith(
        isLoading: false,
        categories: categories,
        bestSalerProducts: bestSalerProducts,
        newProduct: newProduct,
        userModel: user));
  }

  Future<void> _onLoadMorePopular(
      HomeLoadMorePopularEvent event, Emitter<HomeState> emitter) async {
    emitter(state.copyWith(isLoadMorePopular: true));
  }

  Future<void> _onCategoryTap(
      OnTapCategoryEvent event, Emitter<HomeState> emitter) async {
    final List<ProductModel> products =
        await repository.bestSalerProductByCategoryId(event.cateId);
    final ProductModel newProduct =
        await repository.newProductByCategoryId(event.cateId);
    emitter(state.copyWith(
      selectedCategoryIndex: event.cateId,
      bestSalerProducts: products,
      newProduct: newProduct,
    ));
  }

  void _onTapProductDetail(
      OnTapToDetailProductEvent event, Emitter<HomeState> emitter) {
    appNavigator.push(screen: ScreenType.productDetail(event.productModel));
  }

  Future<void> _onTapSearchProduct(
      OnTapSearchProductEvent event, Emitter<HomeState> emitter) async {
    final List<ProductModel> products =
        await repository.searchProducts(event.textSearch);
    emitter(state.copyWith(searchProductsResult: products));
  }

  Future<void> _onTapLogOut(
      OnTapLogOutEvent event, Emitter<HomeState> emitter) async {
    await repository.logOut();
    appNavigator.pushAndRemoveUntil(screen: const ScreenType.login());
  }

  Future<void> _onAddToCart(
      OnTapAddProductToCart event, Emitter<HomeState> emitter) async {
    final int result = await repository.addProductToCart(event.cartModel);
    if (result != 0) {
      EasyLoading.showSuccess('Product added to cart successfully!');
    } else {
      EasyLoading.showError('Product added to cart failed!');
    }
  }
}
