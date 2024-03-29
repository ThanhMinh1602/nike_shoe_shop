import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_catergory/domain/repository/ad_category_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/admin_service.dart';
import 'package:nike_shoe_shop/services/remote/home_service.dart';

class AdCategoryRepositoryImpl implements IAdCategoryRepository {
  final HomeService homeService = HomeService();
  final AdminService adminService = AdminService();
  @override
  Future<void> addNewCategory(CategoryModel category) async {
    await adminService.addNewCategory(category);
  }

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    return await homeService.fetchCategories();
  }
}
