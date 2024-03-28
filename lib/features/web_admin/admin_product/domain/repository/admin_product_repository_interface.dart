import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';

abstract class IAdminProductRepository {
  Future<List<CategoryModel>> getCategories();
}
