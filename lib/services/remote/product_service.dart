import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nike_shoe_shop/common/constants/define_collection.dart';
import 'package:nike_shoe_shop/entities/models/add_product_model.dart';
import 'package:nike_shoe_shop/entities/models/product_model.dart';
import 'package:path/path.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<void> addNewProduct(AddProductModel product) async {
    try {
      String fileName = basename(product.image.path);
      String imageStoragePath =
          '/${AppDefineCollection.APP_PRODUCT}/${product.cateName}/$fileName';
      List<int> sizes = [];
      for (int i = product.minSize; i <= product.maxSize; i++) {
        sizes.add(i);
      }
      final Reference ref = storage.ref().child(imageStoragePath);
      final UploadTask uploadTask = ref.putFile(product.image);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String imageUrl = await downloadUrl.ref.getDownloadURL();

      final docRef = await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .add(ProductModel(
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
    } catch (e) {
      throw Exception('Error adding new product: $e');
    }
  }

  Future<List<ProductModel>> fetchAllProductsByCreateAt() async {
    try {
      final querySnapshot = await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .orderBy('createAt', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }

  Future<List<ProductModel>> fetchBestSalerProducts() async {
    try {
      final querySnapshot = await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .orderBy('orderCount', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching best saler products: $e');
    }
  }

  Future<List<ProductModel>> fetchNewProducts() async {
    try {
      final querySnapshot = await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .orderBy('createAt', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching new products: $e');
    }
  }

  Future<List<ProductModel>> searchProducts(String searchText) async {
    String searchTermLower = searchText.toLowerCase();

    List<ProductModel> matchedProducts = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppDefineCollection.APP_PRODUCT)
          .get();
      for (var doc in querySnapshot.docs) {
        String nameLower = doc['name'].toLowerCase();
        if (nameLower.contains(searchTermLower)) {
          matchedProducts
              .add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
      return matchedProducts;
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .doc(product.id)
          .update(product.toJson());
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> deleteProductById(String id) async {
    try {
      await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .doc(id)
          .delete();
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  Future<void> deleteProductByIdCate(String idCate) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .where('categoryId', isEqualTo: idCate)
          .get();
      for (var doc in querySnapshot.docs) {
        await _firestore
            .collection(AppDefineCollection.APP_PRODUCT)
            .doc(doc.id)
            .delete();
      }
    } catch (e) {
      throw Exception('Error deleting products by category: $e');
    }
  }
}
