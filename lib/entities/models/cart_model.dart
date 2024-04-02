class CartModel {
  final int? id;
  final String productId;
  final String productName;
  final String productImage;
  final double productPrice;
  final int quantity;
  final int size;

  CartModel({
    this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.quantity,
    required this.size,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      productPrice: json['productPrice'],
      quantity: json['quantity'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'quantity': quantity,
      'size': size,
    };
  }
}
