import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/features/web_admin/admin_product/domain/repository/admin_product_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/home_service.dart';

class AdminProductRepositoryImpl implements IAdminProductRepository {
  final HomeService homeService = HomeService();
  @override
  Future<List<CategoryModel>> getCategories() async {
    return homeService.fetchCategories();
  }
}
