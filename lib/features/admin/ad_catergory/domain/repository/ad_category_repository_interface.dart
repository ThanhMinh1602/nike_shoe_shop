import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';

abstract class IAdCategoryRepository {
  Future<List<CategoryModel>> getAllCategory();
  Future<void> addNewCategory(CategoryModel category);
}
