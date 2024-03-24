class CartModel {
  final int productId;
  final int quantity;
  final int size;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.size,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      quantity: json['quantity'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'size': size,
    };
  }
}
