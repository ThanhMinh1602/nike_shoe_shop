import 'package:nike_shoe_shop/gen/assets.gen.dart';

class CategoryModel {
  final int id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});
}

List<CategoryModel> categories = [
  CategoryModel(id: 0, name: 'nike', image: Assets.icons.nikeIcon),
  CategoryModel(id: 1, name: 'adidas', image: Assets.icons.adidasIcon),
  CategoryModel(id: 2, name: 'converse', image: Assets.icons.converseIcon),
  CategoryModel(id: 3, name: 'fuma', image: Assets.icons.fumaIcon),
  CategoryModel(
      id: 4, name: 'under armour', image: Assets.icons.underArmourIcon),
];
