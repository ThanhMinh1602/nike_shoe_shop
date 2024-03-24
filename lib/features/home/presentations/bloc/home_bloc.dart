import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nike_shoe_shop/common/navigator/navigator.dart';
import 'package:nike_shoe_shop/entities/models/appmodels/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/home/data/home_repository_impl.dart';

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
    on<HomeInitialEvent>(_onInit);
    on<HomeLoadMorePopularEvent>(_onLoadMorePopular);
    on<OnTapCategoryEvent>(_onCategoryTap);
    on<OnTapToDetailProductEvent>(_onTapProductDetail);
  }

  Future<void> _onInit(
      HomeInitialEvent event, Emitter<HomeState> emitter) async {
    emitter(const HomeInitialState(isLoading: true));
    final List<CategoryModel> categories = await repository.allCategories();
    final List<ProductModel> bestSalerProducts =
        await repository.bestSalerProductByCategoryId(0);
    final ProductModel newProduct = await repository.newProductByCategoryId(0);
    emitter(state.copyWith(
      isLoading: false,
      categories: categories,
      bestSalerProducts: bestSalerProducts,
      newProduct: newProduct,
    ));
  }

  Future<void> _onLoadMorePopular(
      HomeLoadMorePopularEvent event, Emitter<HomeState> emitter) async {
    emitter(state.copyWith(isLoadMorePopular: true));
  }

  Future<void> _onCategoryTap(
      OnTapCategoryEvent event, Emitter<HomeState> emitter) async {
    try {
      final List<ProductModel> products =
          await repository.bestSalerProductByCategoryId(event.cateId);
      final ProductModel newProduct =
          await repository.newProductByCategoryId(event.cateId);
      emitter(state.copyWith(
        selectedCategoryIndex: event.cateId,
        bestSalerProducts: products,
        newProduct: newProduct,
      ));
    } catch (error) {
      throw Exception('Error when get product by category $error');
    }
  }

  void _onTapProductDetail(
      OnTapToDetailProductEvent event, Emitter<HomeState> emitter) {
    appNavigator.push(screen: ScreenType.productDetail(event.productModel));
  }
}
