import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/appmodels/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/services/remote/home_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AppNavigator appNavigator;
  final HomeService homeService;
  HomeBloc({
    required this.appNavigator,
    required this.homeService,
  }) : super(const HomeInitialState()) {
    on(_onInit);
    on(_onLoadMorePopular);
    on(_onLoadMoreNewArrival);
    on(_onTapProductDetail);
    on(_onCategoryTap);
  }
}

extension EventHandle on HomeBloc {
  Future<void> _onInit(
      HomeInitialEvent event, Emitter<HomeState> emitter) async {
    emitter(const HomeInitialState(isLoading: true));
    List<ProductModel> bestSalerProducts = products
        .where((element) => element.orderCount > 300 && element.categoryId == 0)
        .toList();
    List<ProductModel> newProducts =
        products.where((element) => element.id > products.length - 5).toList();
    List<CategoryModel> categoriesData = await homeService.fetchCategories();
    emitter(HomeState(
      isLoading: false,
      bestSalerProducts: bestSalerProducts,
      newProducts: newProducts,
      categories: categoriesData,
    ));
  }

  Future<void> _onLoadMorePopular(
      HomeLoadMorePopularEvent event, Emitter<HomeState> emitter) async {
    emitter(state.copyWith(isLoadMorePopular: true));
  }

  Future<void> _onLoadMoreNewArrival(
      HomeLoadMoreNewArrivalEvent event, Emitter<HomeState> emitter) async {
    emitter(state.copyWith(isLoadMoreNewArrival: true));
  }

  Future<void> _onCategoryTap(
      OnTapCategoryEvent event, Emitter<HomeState> emitter) async {
    final datas = await homeService.fetchProducts();
    List<ProductModel> productDatas = datas
        .where((element) =>
            element.orderCount > 300 && element.categoryId == event.cateId)
        .toList();
    List<CategoryModel> categoriesData = categories;
    emitter(HomeState(
        isLoading: false,
        bestSalerProducts: productDatas,
        categories: categoriesData,
        selectedCategoryIndex: event.cateId));
  }

  Future<void> _onTapProductDetail(
      OnTapToDetailProductEvent event, Emitter<HomeState> emitter) async {
    appNavigator.push(screen: ScreenType.productDetail(event.productModel));
  }
}
