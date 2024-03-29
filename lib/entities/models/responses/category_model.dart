import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final dynamic image;
  final Timestamp? createAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.createAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        createAt: json['createAt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'createAt': Timestamp.now(),
    };
  }
}

// List<CategoryModel> categories = [
//   CategoryModel(id: 0, name: 'adidas', image: Assets.icons.adidasIcon),
//   CategoryModel(id: 1, name: 'nike', image: Assets.icons.nikeIcon),
//   CategoryModel(id: 2, name: 'converse', image: Assets.icons.converseIcon),
//   CategoryModel(id: 3, name: 'fuma', image: Assets.icons.fumaIcon),
//   CategoryModel(
//       id: 4, name: 'under armour', image: Assets.icons.underArmourIcon),
// ];
