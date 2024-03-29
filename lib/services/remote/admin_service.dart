import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nike_shoe_shop/entities/models/requests/add_product_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/category_model.dart';
import 'package:nike_shoe_shop/entities/models/responses/product_model.dart';
import 'package:path/path.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> addNewProduct(AddProductModel product) async {
    String fileName = basename(product.image.path);
    String imageStoragePath = '/products/${product.cateName}/$fileName';
    List<int> sizes = [];
    for (int i = product.minSize; i <= product.maxSize; i++) {
      sizes.add(i);
    }
    final Reference ref = storage.ref().child(imageStoragePath);
    final UploadTask uploadTask = ref.putFile(product.image);
    final TaskSnapshot downloadUrl = await uploadTask;
    final String imageUrl = await downloadUrl.ref.getDownloadURL();

    final docRef = await _firestore.collection('products').add(ProductModel(
          id: '',
          categoryId: product.cateId,
          name: product.productName,
          image: imageUrl,
          price: product.price,
          description: product.desctiption,
          sizes: sizes,
          viewCount: 0,
          orderCount: 0,
          quantity: product.quantity,
        ).toJson());
    String documentId = docRef.id;
    await docRef.update({'id': documentId});
  }

  Future<void> addNewCategory(CategoryModel category) async {
    String fileName = basename(category.image.path);
    String imageStoragePath = '/categories/$fileName';
    final Reference ref = storage.ref().child(imageStoragePath);
    final UploadTask uploadTask = ref.putFile(category.image);
    final TaskSnapshot downloadUrl = await uploadTask;
    final String imageUrl = await downloadUrl.ref.getDownloadURL();
    final docRef = await _firestore.collection('categories').add(
        CategoryModel(id: '', name: category.name, image: imageUrl).toJson());
    String documentId = docRef.id;
    await docRef.update({'id': documentId});
  }
}
