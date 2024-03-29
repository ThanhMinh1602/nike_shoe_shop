import 'package:nike_shoe_shop/entities/models/requests/add_product_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';

abstract class IProductRepository {
  Future<List<CategoryModel>> getAllCategory();
  Future<void> addNewProduct(AddProductModel addProductModel);
}
