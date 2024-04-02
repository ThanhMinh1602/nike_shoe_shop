import 'package:nike_shoe_shop/entities/models/cart_model.dart';
import 'package:nike_shoe_shop/features/product_detail/domain/domain/repository/product_detail_repository_interface.dart';
import 'package:nike_shoe_shop/services/local/cart_service.dart';

class ProductDetailRepositoryImpl implements IProductDetailRepository {
  final CartService cartService = CartService();
  @override
  Future<int> addProductToCart(CartModel cartModel) async {
    return await cartService.addItem(cartModel);
  }
}
