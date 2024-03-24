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

// List<ProductModel> products = [
//   //adidas
//   ProductModel(
//     id: 0,
//     categoryId: 0,
//     name: 'ADIDAS VL COURT BASE',
//     image:
//         'https://myshoes.vn/image/catalog/2024/adidas/ad2/giay-adidas-vl-court-base-nam-trang-xanh-01.jpg',
//     price: 160.0,
//     description:
//         '''Giày adidas VL Court Base được thiết kế phong cách cổ điển nhưng đẹp mãi với thời gian. Một mẫu giày bạn có thể sử dụng trong mọi hoàn cảnh và luôn phù hợp dù ở bất cứ nơi đâu.
// Phần Upper được làm từ da cao cấp với logo đặc trưng của adidas, đế giày chất liệu cao su siêu bền, chắc chắn hỗ trợ từng bước chân.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 1929,
//     orderCount: 617,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 1,
//     categoryId: 0,
//     name: 'ADIDAS SOLARGLIDE 6',
//     image:
//         'https://myshoes.vn/image/catalog/2023/adidas/adi3/giay-adidas-solarglide-6-nam-den-den-01.jpg',
//     price: 1601.0,
//     description:
//         '''Giày adidas VL Court Base được thiết kế phong cách cổ điển nhưng đẹp mãi với thời gian. Một mẫu giày bạn có thể sử dụng trong mọi hoàn cảnh và luôn phù hợp dù ở bất cứ nơi đâu.
// Phần Upper được làm từ da cao cấp với logo đặc trưng của adidas, đế giày chất liệu cao su siêu bền, chắc chắn hỗ trợ từng bước chân.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 1929,
//     orderCount: 593,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 2,
//     categoryId: 0,
//     name: 'ADIDAS PUREBOOST',
//     image:
//         'https://myshoes.vn/image/catalog/2023/adidas/adi3/giay-adidas-ultraboost-light-nam-xam-den-xanh-01.jpg',
//     price: 110.0,
//     description:
//         '''Giày adidas VL Court Base được thiết kế phong cách cổ điển nhưng đẹp mãi với thời gian. Một mẫu giày bạn có thể sử dụng trong mọi hoàn cảnh và luôn phù hợp dù ở bất cứ nơi đâu.
// Phần Upper được làm từ da cao cấp với logo đặc trưng của adidas, đế giày chất liệu cao su siêu bền, chắc chắn hỗ trợ từng bước chân.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 1929,
//     orderCount: 389,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 3,
//     categoryId: 0,
//     name: 'ADIDAS SUPERSTAR',
//     image:
//         'https://myshoes.vn/image/catalog/2023/adidas/adi2/giay-adidas-superstar-nam-%20xanh-vang-01.jpg',
//     price: 195.0,
//     description:
//         '''Giày adidas VL Court Base được thiết kế phong cách cổ điển nhưng đẹp mãi với thời gian. Một mẫu giày bạn có thể sử dụng trong mọi hoàn cảnh và luôn phù hợp dù ở bất cứ nơi đâu.
// Phần Upper được làm từ da cao cấp với logo đặc trưng của adidas, đế giày chất liệu cao su siêu bền, chắc chắn hỗ trợ từng bước chân.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 1929,
//     orderCount: 389,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 4,
//     categoryId: 0,
//     name: 'ADIDAS GRAND COURT',
//     image:
//         'https://myshoes.vn/image/catalog/2023/adidas/adi3/giay-adidas-grand-court-base-2-nam-trang-01.jpg',
//     price: 195.0,
//     description:
//         '''Giày adidas VL Court Base được thiết kế phong cách cổ điển nhưng đẹp mãi với thời gian. Một mẫu giày bạn có thể sử dụng trong mọi hoàn cảnh và luôn phù hợp dù ở bất cứ nơi đâu.
// Phần Upper được làm từ da cao cấp với logo đặc trưng của adidas, đế giày chất liệu cao su siêu bền, chắc chắn hỗ trợ từng bước chân.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 1929,
//     orderCount: 821,
//     quantity: 1000,
//   ),

//   //NIKE
//   ProductModel(
//     id: 5,
//     categoryId: 1,
//     name: 'NIKE SB HERITAGE VULC',
//     image:
//         'https://myshoes.vn/image/catalog/2024/nike/nk2/giay-nike-sb-heritage-vulc-nam-xam-xanh-navy-01.jpg',
//     price: 195.0,
//     description:
//         '''Giày Nike SB Heritage Vulc là dòng giày sneaker có thiết kế classic được rất nhiều người yêu thích. Một mẫu giày bạn có thể tự tin sử dụng trong mọi hoàn cảnh mà không sợ lỗi mốt.
// Phần upper của giày được làm từ chất liệu da lộn cao cấp, đế giày làm bằng cao su với công nghệ độc quyền của Nike siêu bền.
// Giày Nike SB Heritage Vulc tại Myshoes.vn được nhập khẩu chính hãng. Full box, đầy đủ phụ kiện. ''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 616,
//     orderCount: 939,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 6,
//     categoryId: 1,
//     name: 'NIKE AIR MAX INTRLK NỮ',
//     image:
//         'https://myshoes.vn/image/catalog/2024/nike/nk2/giay-nike-air-max-intrlk-lite-nu-trang-tim-hong-01.jpg',
//     price: 195.0,
//     description:
//         '''Giày Nike Air Max INTRLK là mẫu giày với thiết kế vô cùng thời trang của Nike với sự kết hợp hài hòa giữa quá khứ và hiện đại.
// Phần đế giữa của Nike Air Max INTRLK được thiết kế rất hợp lý mềm mại với công nghệ tiên tiến nhất của Nike. Chắc chắn đây là mẫu giày mà bất cứ fan Sneaker không thể bỏ qua
// Giày Nike Air Max INTRLK tại Myshoes.vn được nhập khẩu chính hãng từ Nike. Full box, đầy đủ phụ kiện.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 341,
//     orderCount: 643,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 7,
//     categoryId: 1,
//     name: 'NIKE JUNIPER TRAIL',
//     image:
//         'https://myshoes.vn/image/catalog/2024/nike/nk2/giay-nike-juniper-trail-nam-camo-01.jpg',
//     price: 195.0,
//     description:
//         '''Giày Nike Juniper Trail là một mẫu giày trail có thiết kế rất thời trang. Bạn có thể sử dụng mẫu giày này để chạy bộ hay đi lại hàng ngày đều rất phù hợp.
// Với thiết kế đẹp, phần upper chất liệu vải mesh thoáng khí và bộ đế cực kỳ êm ái. Giày Nike Juniper Trail sẽ giúp bạn thoải mái đi lại trong cả ngày dài.
// Giày Nike Juniper Trail được Myshoes.vn nhập khẩu chính hãng, full box, đầy đủ phụ kiện.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 523,
//     orderCount: 745,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 8,
//     categoryId: 1,
//     name: 'NIKE WEARALLDAY',
//     image:
//         'https://myshoes.vn/image/catalog/2024/nike/nk2/giay-nike-wearallday-nu-hong-trang-01.jpg',
//     price: 195.0,
//     description:
//         '''Giày Nike Wearallday là mẫu giày được các nhà thiết kế của NIKE giúp bạn có thể mang nó ca ngày mà không bị bí bách, khó chịu đúng như tên gọi của nó - wearallday. Kiểu dáng trẻ trung giúp bạn tự tin kết hợp cùng các kiêu Outfit khác nhau.
// Giày Nike Wearallday tại Myshoes.vn được nhập khẩu chính hãng. Full box, đầy đủ phụ kiện.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 785,
//     orderCount: 436,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 9,
//     categoryId: 1,
//     name: 'NIKE SB ALLEYOOP',
//     image:
//         'https://myshoes.vn/image/catalog/2024/nike/nk2/giay-nikesb-alleyoop-nam-xam-xanh-01.jpg',
//     price: 195.0,
//     description:
//         '''Giày Nike SB Alleyoop là dòng giày sneaker có thiết kế đơn giản nhưng đẹp mắt, được rất nhiều người yêu thích. Một mẫu giày bạn có thể tự tin sử dụng trong mọi hoàn cảnh mà không sợ lỗi mốt.
// Phần upper của giày được làm từ chất liệu da lộn cao cấp kết hợp với vải Canvas chắc chắn chịu va chạm mài mòn tốt, đế giày làm bằng cao su với công nghệ độc quyền của Nike siêu bền.
// Giày Nike SB Alleyoop tại Myshoes.vn được nhập khẩu chính hãng. Full box, đầy đủ phụ kiện. ''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 653,
//     orderCount: 341,
//     quantity: 1000,
//   ),

//   // converse
//   ProductModel(
//     id: 10,
//     categoryId: 2,
//     name: 'Chuck Taylor All Star 1970s',
//     image:
//         'https://drake.vn/image/cache/catalog/Converse/A05589C/A05589C-650x650.jpg',
//     price: 195.0,
//     description:
//         '''Giày Nike SB Alleyoop là dòng giày sneaker có thiết kế đơn giản nhưng đẹp mắt, được rất nhiều người yêu thích. Một mẫu giày bạn có thể tự tin sử dụng trong mọi hoàn cảnh mà không sợ lỗi mốt.
// Phần upper của giày được làm từ chất liệu da lộn cao cấp kết hợp với vải Canvas chắc chắn chịu va chạm mài mòn tốt, đế giày làm bằng cao su với công nghệ độc quyền của Nike siêu bền.
// Giày Nike SB Alleyoop tại Myshoes.vn được nhập khẩu chính hãng. Full box, đầy đủ phụ kiện. ''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 231,
//     orderCount: 676,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 11,
//     categoryId: 2,
//     name: 'Chuck Taylor All Star 1970s',
//     image:
//         'https://drake.vn/image/cache/catalog/Converse/A05585C/A05585C-650x650.jpg',
//     price: 195.0,
//     description:
//         '''Ấn tượng với phối màu mới mẻ được lấy cảm hứng từ lông chim mòng két, Converse Chuck 70s Teal Universe nổi bật với tone màu xanh lam ấn tượng. Tone màu đại diện cho sự cởi mở, sáng suốt và sáng tạo mang đến cảm giác nhẹ nhàng Thiết kế cổ cao và cổ thấp cùng kết cấu nội thất tiện nghi sẽ làm bạn hài lòng với item này.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 856,
//     orderCount: 342,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 12,
//     categoryId: 2,
//     name: 'Chuck 70 At Cx Counter Climate',
//     image:
//         'https://drake.vn/image/cache/catalog/Hinh%20add%20dut%20size/17.01.24/A03277C-1-650x650-650x650.jpg',
//     price: 195.0,
//     description:
//         '''Nâng tầm phong cách với Converse Chuck 70 AT CX kết hợp hoàn hảo giữa tính sáng tạo và sự thoải mái.
//          Thiết kế hướng tới tương lai với những đường nét táo bạo và cung cấp các nâng cấp về độ bám và đệm cực 
//          kỳ thoải mái. Vẻ ngoài lấy cảm hứng cổ điển của Chuck 70, kết hợp phần đế thiết kế to bản có cấu trúc 
//          dạng hai đế. Đế dưới có vấu kim cương giúp gia tăng lực ma sát, mũi giày được bao bọc bởi TPU Bosey Toe.
//           Cuối cùng, công nghệ CX mới nhất giúp thiết kế trở thành items không thể thiếu đối với bất kỳ tín đồ đam 
//           mê sneaker nào.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 754,
//     orderCount: 634,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 13,
//     categoryId: 2,
//     name: 'Run Star Motion Canvas Platform',
//     image:
//         'https://drake.vn/image/cache/catalog/Converse/GIA%CC%80Y%202/172896C/172896C-5-650x650.jpg',
//     price: 195.0,
//     description:
//         '''Converse Run Star Motion một hình thể mới được nâng cấp và khai thác cho thông điệp
//          “Innovation” bắt nguồn từ đôi Run Star Hike. Phiên bản được xem là “dân chơi” của thế
//           hệ mới khi sở hữu cấu hình nâng cấp về chất liệu cũng như tính năng. Hiện đại với công 
//           nghệ bọt CX Foam Insole và táo bạo với đế ngoài Platform phóng đại gợn sóng cường điệu
//            tạo lực kéo vượt trội. BST được xây dựng dựa trên ý niệm thời trang tương lai và tinh
//             thần Create Next Comfort.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 673,
//     orderCount: 943,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 14,
//     categoryId: 2,
//     name: 'Chuck Taylor All Star Lift Outline Sketch',
//     image:
//         'https://drake.vn/image/cache/catalog/Hinh%20add%20dut%20size/17.01.24/A05071C_1-650x650-650x650.jpg',
//     price: 195.0,
//     description:
//         '''Converse Lift Outline Sketch mang đến một làn gió mới lạ với thiết kế vô cùng ấn tượng. Sở hữu phối 
//         màu Black/White/Black cổ điển cùng với chất liệu canvas bền bỉ, phần đế Platform được tách lớp cực kỳ
//          độc đáo. Ngoài ra, Patch Logo tròn bên hông thân giày được làm bằng chất liệu da lộn và thêu trực tiếp
//           lên giày. Dây giày được phối màu đen viền trắng mang lại cho đôi giày cái nhìn tổng thể thời thượng, 
//           bắt mắt mà các tín đồ sneaker phải mê mẩn.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 845,
//     orderCount: 342,
//     quantity: 1000,
//   ),
//   //Fuma
//   ProductModel(
//     id: 15,
//     categoryId: 3,
//     name: 'PUMA V6 LOW',
//     image:
//         'https://myshoes.vn/image/catalog/2024/puma/pm1/giay-puma-v6-low-nam-trang-xanh-01.jpg',
//     price: 562.0,
//     description:
//         '''Giày Puma V6 Low là mẫu giày có thiết kế tuyệt đẹp cổ điển mà rất tinh tế. Chất liệu da
//          cao cấp và đế cao su bền bỉ chắc chắn sẽ làm hài lòng những khách hàng khó tính nhất. 
//          Bạn sẽ luôn yên tâm rằng nó không bao giờ bị lỗi mốt.
// Giày Puma V6 Low tại Myshoes.vn được nhập khẩu chính hãng Full box, đầy đủ phụ kiện.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 745,
//     orderCount: 783,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 16,
//     categoryId: 3,
//     name: 'PUMA V6 LOW NAM',
//     image:
//         'https://myshoes.vn/image/catalog/2024/puma/pm1/giay-puma-v6-low-nam-trang-den-01.jpg',
//     price: 123.0,
//     description:
//         '''Giày Puma V6 Low là mẫu giày có thiết kế tuyệt đẹp cổ điển mà rất tinh tế. Chất liệu 
//         da cao cấp và đế cao su bền bỉ chắc chắn sẽ làm hài lòng những khách hàng khó tính nhất. Bạn sẽ luôn yên tâm rằng nó không bao giờ bị lỗi mốt.
// Giày Puma V6 Low tại Myshoes.vn được nhập khẩu chính hãng Full box, đầy đủ phụ kiện.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 796,
//     orderCount: 578,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 17,
//     categoryId: 3,
//     name: 'PUMA REBOUND JOY LOW',
//     image:
//         'https://myshoes.vn/image/catalog/2023/puma/pu2/giay-puma-rebound-joy-low-nam-trang-ghi-01.jpg',
//     price: 456.0,
//     description:
//         '''Giày Puma Rebound Joy Low là mẫu giày có thiết kế tuyệt đẹp cổ điển mà rất tinh tế. Chất liệu da cao
//         cấp và đế cao su bền bỉ chắc chắn sẽ làm hài lòng những khách hàng khó tính nhất. Bạn sẽ luôn yên tâm 
//         rằng nó không bao giờ bị lỗi mốt.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 856,
//     orderCount: 475,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 18,
//     categoryId: 3,
//     name: 'PUMA SHUFFLE PERFORATED',
//     image:
//         'https://myshoes.vn/image/catalog/2023/puma/pu2/giay-puma-shuffle-perforated-nam-trang-01.jpg',
//     price: 654.0,
//     description:
//         '''Giày Puma Shuffle Perforated mẫu giày cổ điển lấy cảm hứng từ những 1980 của Puma. Chất liệu da
//         cao cấp và đế cao su bền bỉ chắc chắn sẽ làm hài lòng những khách hàng khó tính nhất. Bạn sẽ luôn 
//         yên tâm rằng nó không bao giờ bị lỗi mốt.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 743,
//     orderCount: 846,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 19,
//     categoryId: 3,
//     name: 'PUMA PWRFRAME TR 2',
//     image:
//         'https://myshoes.vn/image/catalog/2023/puma/pu01/giay-puma-pwrframe-tr-2-nam-navy-do-01.jpg',
//     price: 785.0,
//     description:
//         '''Giày Puma PWRFrame TR 2 mẫu giày training có thiết kế rất đẹp cùng với những công nghệ cao 
//         cấp của Puma. Đây chính là mẫu giày đa năng tuyệt vời cho luyện tập thể thao, tập gym và các hoạt động hàng ngày.''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 345,
//     orderCount: 754,
//     quantity: 1000,
//   ),
//   //Under armour
//   ProductModel(
//     id: 20,
//     categoryId: 4,
//     name: 'Under Armour HOVR Phantom 3 ‘Black Gold’ ',
//     image:
//         'https://product.hstatic.net/1000008082/product/2x1_7b2994276483417cbabb0e4e0cb155a4_grande.jpg',
//     price: 423.0,
//     description:
//         '''Mua Giày Under Armour HOVR Phantom 3 ‘Black Gold’ 3025520-003 chính hãng 100% có sẵn tại Authentic Shoes. Giao hàng miễn phí 
//         trong 1 ngày.Cam kết đền tiền X5 nếu phát hiện Fake. Đổi trả miễn phí size. FREE vệ sinh giày trọn đời. MUA NGAY!''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 342,
//     orderCount: 456,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 21,
//     categoryId: 4,
//     name: 'Under Armour Curry Flow 8 ‘Shine’',
//     image:
//         'https://product.hstatic.net/1000008082/product/11_cafdd005ff3644b4b7b301b267548874_grande.jpg',
//     price: 341.0,
//     description:
//         '''Mua Giày Under Armour Curry Flow 8 ‘Shine’ 3024031-100 chính hãng 100% có sẵn tại Authentic Shoes. Giao hàng miễn phí trong 1 ngày. Cam kết đền tiền X5 nếu phát hiện Fake. Đổi trả miễn phí size. FREE vệ sinh giày trọn đời. MUA NGAY!''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 421,
//     orderCount: 758,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 22,
//     categoryId: 4,
//     name: ' Under Armour HOVR Infinite 2 ‘Black’',
//     image:
//         'https://product.hstatic.net/1000361048/product/3022121-001_a_f47d2f274a76425ead075eab155fd21e_grande.jpeg',
//     price: 956.0,
//     description:
//         '''Mua Giày Under Armour HOVR Infinite 2 ‘Black’ 3022587-001 chính hãng 100% có sẵn tại Authentic Shoes. Giao hàng 
//         miễn phí trong 1 ngày. Cam kết đền tiền X5 nếu phát hiện Fake. Đổi trả miễn phí size. FREE vệ sinh giày trọn đời. MUA NGAY !''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 574,
//     orderCount: 846,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 23,
//     categoryId: 4,
//     name: 'Under Armour Curry Flow 8 ‘Flow Like Water’ ',
//     image:
//         'https://product.hstatic.net/1000361048/product/3020612-402_a_f2a3020cb0474dbeb1fdf122cedc28ed_grande.jpeg',
//     price: 234.0,
//     description:
//         '''Mua Giày Under Armour Curry Flow 8 ‘Flow Like Water’ 3023085-402 chính hãng 100% có sẵn tại Authentic Shoes. Giao hàng miễn phí
//          trong 1 ngày. Cam kết đền tiền X5 nếu phát hiện Fake. Đổi trả miễn phí size. FREE vệ sinh giày trọn đời. MUA NGAY!''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 674,
//     orderCount: 312,
//     quantity: 1000,
//   ),
//   ProductModel(
//     id: 24,
//     categoryId: 4,
//     name: 'Under Armour Curry Flow ‘Iron Sharpens’',
//     image:
//         'https://product.hstatic.net/1000361048/product/3023949-003_default_4f78f159d6894967a907a6891460f9f8_master.jpeg',
//     price: 765.0,
//     description:
//         '''Mua Giày Under Armour Curry Flow ‘Iron Sharpens’ 3025620-001 chính hãng 100% có sẵn tại Authentic Shoes. Giao hàng miễn
//          phí trong 1 ngày. Cam kết đền tiền X5 nếu phát hiện Fake. Đổi trả miễn phí size. FREE vệ sinh trọn đời. MUA NGAY!''',
//     sizes: [40, 41, 42, 43, 44, 45],
//     viewCount: 744,
//     orderCount: 874,
//     quantity: 1000,
//   ),
// ];
