class ProductModel {
  final int id;
  final int categoryId;
  final String name;
  final String image;
  final double price;
  final String description;
  final List<int> sizes;
  final int viewCount;
  final int orderCount;
  final int quantity;

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
      required this.quantity});

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
    );
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
      };
}

List<ProductModel> products = [
  ProductModel(
    id: 0,
    categoryId: 1,
    name: 'Nike Air Max 90',
    image:
        'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers.png',
    price: 160.0,
    description:
        'Air Jordan is an American brand of basketball shoes athletic, casual, and'
        ' style clothing produced by Nike, Air Jordan is an American brand of '
        'basketball shoes athletic, casual, and style clothing produced by Nike',
    sizes: [40, 41, 42, 43, 44, 45],
    viewCount: 1929,
    orderCount: 500,
    quantity: 1000,
  ),
  ProductModel(
    id: 0,
    categoryId: 1,
    name: 'Nike Air Max 90',
    image:
        'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers.png',
    price: 160.0,
    description:
        'Air Jordan is an American brand of basketball shoes athletic, casual, and'
        ' style clothing produced by Nike, Air Jordan is an American brand of '
        'basketball shoes athletic, casual, and style clothing produced by Nike',
    sizes: [40, 41, 42, 43, 44, 45],
    viewCount: 1929,
    orderCount: 500,
    quantity: 1000,
  ),
  ProductModel(
    id: 1,
    categoryId: 2,
    name: 'Adidas Superstar',
    image:
        'https://e7.pngegg.com/pngimages/382/622/png-clipart-sneakers-skate-shoe-nike-one-nike-shoe-purple-fashion.png',
    price: 111.0,
    description:
        'Air Jordan is an American brand of basketball shoes athletic, casual, and'
        ' style clothing produced by Nike, Air Jordan is an American brand of '
        'basketball shoes athletic, casual, and style clothing produced by Nike',
    sizes: [40, 41, 42, 43, 44, 45],
    viewCount: 984,
    orderCount: 123,
    quantity: 123,
  ),
  ProductModel(
    id: 2,
    categoryId: 0,
    name: 'Converse Chuck Taylor',
    image:
        'https://img.favpng.com/18/1/3/air-force-1-nike-air-zoom-pegasus-34-men-s-sports-shoes-png-favpng-QgR1M0Lzy7ZF24VaPdUfJJRGe.jpg',
    price: 163.0,
    description:
        'Air Jordan is an American brand of basketball shoes athletic, casual, and'
        ' style clothing produced by Nike, Air Jordan is an American brand of '
        'basketball shoes athletic, casual, and style clothing produced by Nike',
    sizes: [40, 41, 42, 43, 44, 45],
    viewCount: 765,
    orderCount: 43,
    quantity: 896,
  ),
  ProductModel(
    id: 3,
    categoryId: 1,
    name: 'Nike Air Max 90',
    image:
        'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers.png',
    price: 160.0,
    description:
        'Air Jordan is an American brand of basketball shoes athletic, casual, and'
        ' style clothing produced by Nike, Air Jordan is an American brand of '
        'basketball shoes athletic, casual, and style clothing produced by Nike',
    sizes: [40, 41, 42, 43, 44, 45],
    viewCount: 1929,
    orderCount: 500,
    quantity: 1000,
  ),
  ProductModel(
    id: 4,
    categoryId: 1,
    name: 'Nike Air Max 90',
    image:
        'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers.png',
    price: 160.0,
    description:
        'Air Jordan is an American brand of basketball shoes athletic, casual, and'
        ' style clothing produced by Nike, Air Jordan is an American brand of '
        'basketball shoes athletic, casual, and style clothing produced by Nike',
    sizes: [40, 41, 42, 43, 44, 45],
    viewCount: 1929,
    orderCount: 500,
    quantity: 1000,
  ),
  ProductModel(
    id: 5,
    categoryId: 1,
    name: 'Nike Air Max 90',
    image:
        'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers.png',
    price: 160.0,
    description:
        'Air Jordan is an American brand of basketball shoes athletic, casual, and'
        ' style clothing produced by Nike, Air Jordan is an American brand of '
        'basketball shoes athletic, casual, and style clothing produced by Nike',
    sizes: [40, 41, 42, 43, 44, 45],
    viewCount: 1929,
    orderCount: 500,
    quantity: 1000,
  ),
  ProductModel(
    id: 6,
    categoryId: 2,
    name: 'Nike Air Max 90',
    image:
        'https://w7.pngwing.com/pngs/323/773/png-transparent-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers.png',
    price: 110.0,
    description:
        'Air Jordan is an American brand of basketball shoes athletic, casual, and'
        ' style clothing produced by Nike, Air Jordan is an American brand of '
        'basketball shoes athletic, casual, and style clothing produced by Nike',
    sizes: [40, 41, 42, 43, 44, 45],
    viewCount: 876,
    orderCount: 45,
    quantity: 23,
  )
];
