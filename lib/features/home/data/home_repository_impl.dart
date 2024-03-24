import 'package:nike_shoe_shop/entities/models/appmodels/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/home/domain/repository/home_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/home_service.dart';

class HomeRepositoryImpl implements IHomeRepository {
  final HomeService homeService = HomeService();

  @override
  Future<List<CategoryModel>> allCategories() async {
    return homeService.fetchCategories();
  }

  @override
  Future<List<ProductModel>> bestSalerProductByCategoryId(int cateId) async {
    final List<ProductModel> products =
        await homeService.fetchBestSalerProducts();
    return products.where((element) => element.categoryId == cateId).toList();
  }

  @override
  Future<ProductModel> newProductByCategoryId(int cateId) async {
    final List<ProductModel> products = await homeService.fetchNewProducts();

    return products.firstWhere((element) => element.categoryId == cateId);
  }
}
