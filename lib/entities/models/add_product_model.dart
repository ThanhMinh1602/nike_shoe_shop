import 'dart:io';

class AddProductModel {
  final String productName;
  final double price;
  final int quantity;
  final int minSize;
  final int maxSize;
  final String cateId;
  final String cateName;
  final String desctiption;
  final File image;

  AddProductModel(
      {required this.productName,
      required this.price,
      required this.quantity,
      required this.minSize,
      required this.maxSize,
      required this.cateId,
      required this.cateName,
      required this.desctiption,
      required this.image});
}
