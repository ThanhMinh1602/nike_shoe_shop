// // import 'package:flutter/material.dart';
// // import 'package:firebase_storage/firebase_storage.dart';

// // class ImageFromFirebaseStorage extends StatefulWidget {
// //   @override
// //   _ImageFromFirebaseStorageState createState() =>
// //       _ImageFromFirebaseStorageState();
// // }

// // class _ImageFromFirebaseStorageState extends State<ImageFromFirebaseStorage> {
// //   String imageUrl = ''; // Biến lưu trữ URL của hình ảnh

// //   @override
// //   void initState() {
// //     super.initState();
// //     loadImage();
// //   }

// //   Future<void> loadImage() async {
// //     try {
// //       String url = await FirebaseStorage.instance
// //           .ref()
// //           .child(
// //               '/products/adidas/adidas_0.jpg')
// //           .getDownloadURL();

// //       setState(() {
// //         imageUrl = url; // Lưu URL vào biến imageUrl
// //       });
// //     } catch (e) {
// //       print('Error loading image from Firebase Storage: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     print(imageUrl);
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Image from Firebase Storage'),
// //       ),
// //       body: Center(
// //         child: imageUrl != null
// //             ? Image.network(imageUrl) // Hiển thị hình ảnh từ URL
// //             : CircularProgressIndicator(), // Hiển thị indicator nếu hình ảnh chưa được tải
// //       ),
// //     );
// //   }
// // }

// // void main() {
// //   runApp(MaterialApp(
// //     home: ImageFromFirebaseStorage(),
// //   ));
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:nike_shoe_shop/entities/models/appmodels/category_model.dart';
// import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';

// class ImportDataScreen extends StatelessWidget {
//   const ImportDataScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Import Data to Firestore'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             // Get a Firestore instance
//             FirebaseFirestore firestore = FirebaseFirestore.instance;

//             // Loop through the products list and add each product to Firestore
//             for (CategoryModel category in categories) {
//               await firestore.collection('categories').add(category.toJson());
//             }

//             // Show a snackbar to indicate that the data has been imported
//             // ignore: use_build_context_synchronously
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Data imported to Firestore successfully!'),
//               ),
//             );
//           },
//           child: const Text('Import Data'),
//         ),
//       ),
//     );
//   }
// }
