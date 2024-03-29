import 'package:nike_shoe_shop/entities/models/requests/add_product_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/domain/repository/ad_product_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/admin_service.dart';
import 'package:nike_shoe_shop/services/remote/home_service.dart';

class ProductRepositoryImpl implements IProductRepository {
  final HomeService homeService = HomeService();
  final AdminService adminService = AdminService();
  @override
  Future<List<CategoryModel>> getAllCategory() async {
    return await homeService.fetchCategories();
  }

  @override
  Future<void> addNewProduct(AddProductModel addProductModel) async {
    await adminService.addNewProduct(addProductModel);
  }
}
