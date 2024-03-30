import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_catergory/domain/repository/ad_category_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/category_service.dart';

class AdCategoryRepositoryImpl implements IAdCategoryRepository {
  final CategoryService categoryService = CategoryService();
  @override
  Future<void> addNewCategory(CategoryModel category) async {
    await categoryService.addNewCategory(category);
  }

  @override
  Future<List<CategoryModel>> getAllCategory() async {
    return await categoryService.fetchCategories();
  }

  @override
  Future<void> deleteAllCategory() {
    // TODO: implement deleteAllCategory
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(String id) async {
    await categoryService.deleteCategory(id);
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    await categoryService.updateCategory(category);
  }
}
