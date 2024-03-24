import 'dart:convert';

import 'package:nike_shoe_shop/entities/models/local_model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static const String cartKey = 'cart';

  static late SharedPreferences _prefs;
  static List<CartModel> get cart {
    final List<String>? cartStrings = _prefs.getStringList(cartKey);
    if (cartStrings == null) {
      return [];
    }
    return cartStrings.map((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return CartModel.fromJson(json);
    }).toList();
  }

  static set cart(List<CartModel> cart) {
    final List<String> cartStrings =
        cart.map((cartModel) => jsonEncode(cartModel.toJson())).toList();
    _prefs.setStringList(cartKey, cartStrings);
  }

  static removeCartByIndex(int index) {
    List<CartModel> cart = CartService.cart;
    cart.removeAt(index);
    CartService.cart = cart;
  }
}
