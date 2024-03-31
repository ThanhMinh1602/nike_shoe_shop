import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nike_shoe_shop/common/constants/define_collection.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final querySnapshot = await _firestore
          .collection(AppDefineCollection.APP_CATEGORY)
          .orderBy('createAt', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  // Future<void> addNewCategory(CategoryModel category) async {
  //   try {
  //     String docId =
  //         _firestore.collection(AppDefineCollection.APP_CATEGORY).doc().id;
  //     String imageStoragePath = '/${AppDefineCollection.APP_CATEGORY}/$docId';
  //     final Reference ref = storage.ref().child(imageStoragePath);
  //     final UploadTask uploadTask = ref.putFile(category.image);
  //     final TaskSnapshot downloadUrl = await uploadTask;
  //     final String imageUrl = await downloadUrl.ref.getDownloadURL();
  //     await _firestore
  //         .collection(AppDefineCollection.APP_CATEGORY)
  //         .doc(docId)
  //         .set(CategoryModel(
  //                 id: docId,
  //                 name: category.name,
  //                 image: imageUrl,
  //                 createAt: Timestamp.now())
  //             .toJson());
  //   } catch (e) {
  //     throw Exception('Error adding new category: $e');
  //   }
  // }

  // Future<void> updateCategory(CategoryModel category) async {
  //   try {
  //     final Map<String, dynamic> categoryData = {
  //       'name': category.name,
  //       'createAt': Timestamp.now(),
  //     };

  //     if (category.image != null) {
  //       final String imageStoragePath =
  //           '/${AppDefineCollection.APP_CATEGORY}/${category.id}';
  //       final Reference ref = storage.ref().child(imageStoragePath);
  //       final UploadTask uploadTask = ref.putFile(category.image);
  //       final TaskSnapshot downloadUrl = await uploadTask;
  //       final String imageUrl = await downloadUrl.ref.getDownloadURL();
  //       categoryData['image'] = imageUrl;
  //     }

  //     await _firestore
  //         .collection(AppDefineCollection.APP_CATEGORY)
  //         .doc(category.id)
  //         .update(categoryData);
  //   } catch (e) {
  //     throw Exception('Error updating category: $e');
  //   }
  // }

  // Future<void> deleteCategory(String idCate) async {
  //   try {
  //     await _firestore
  //         .collection(AppDefineCollection.APP_CATEGORY)
  //         .doc(idCate)
  //         .delete();
  //     String imageStoragePath = '/${AppDefineCollection.APP_CATEGORY}/$idCate';
  //     final Reference ref = storage.ref().child(imageStoragePath);
  //     await ref.delete();
  //   } catch (e) {
  //     throw Exception('Error deleting category: $e');
  //   }
  // }
}
