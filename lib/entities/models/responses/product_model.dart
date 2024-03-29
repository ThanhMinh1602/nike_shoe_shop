import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String categoryId;
  final String name;
  final String image;
  final double price;
  final String description;
  final List<int> sizes;
  final int viewCount;
  final int orderCount;
  final int quantity;
  final Timestamp? createAt;

  ProductModel(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.image,
      required this.price,
      required this.description,
      required this.sizes,
      required this.viewCount,
      required this.orderCount,
      required this.quantity,
      this.createAt});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        categoryId: json['categoryId'],
        name: json['name'],
        image: json['image'],
        price: json['price'],
        description: json['description'],
        sizes: json['sizes'].cast<int>(),
        viewCount: json['viewCount'],
        orderCount: json['orderCount'],
        quantity: json['quantity'],
        createAt: json['createAt']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoryId': categoryId,
        'name': name,
        'image': image,
        'price': price,
        'description': description,
        'sizes': sizes,
        'viewCount': viewCount,
        'orderCount': orderCount,
        'quantity': quantity,
        'createAt': Timestamp.now(),
      };
}
