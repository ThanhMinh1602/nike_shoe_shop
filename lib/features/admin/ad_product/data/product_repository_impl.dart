import 'package:nike_shoe_shop/entities/models/requests/add_product_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:nike_shoe_shop/features/admin/ad_product/domain/repository/ad_product_repository_interface.dart';
import 'package:nike_shoe_shop/services/remote/category_service.dart';
import 'package:nike_shoe_shop/services/remote/product_service.dart';

class ProductRepositoryImpl implements IProductRepository {
  final CategoryService categoryService = CategoryService();
  final ProductService productService = ProductService();
  @override
  Future<List<CategoryModel>> getAllCategory() async {
    return await categoryService.fetchCategories();
  }

  @override
  Future<void> addNewProduct(AddProductModel addProductModel) async {
    await productService.addNewProduct(addProductModel);
  }

  @override
  Future<void> deleteAllProduct() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String productID) async {
    await productService.deleteProductById(productID);
  }

  @override
  Future<List<ProductModel>> getAllProduct() async {
    return await productService.fetchAllProductsByCreateAt();
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    throw UnimplementedError();
  }
}
