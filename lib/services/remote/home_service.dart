import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getAllHotels() async {
    try {
      // Lấy tất cả các documents từ collection "hotels"
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('hotels').get();

      // Chuyển đổi danh sách các documents thành một Map
      Map<String, dynamic> hotelMap = {};
      querySnapshot.docs.forEach((doc) {
        hotelMap[doc.id] = doc.data();
      });

      return hotelMap;
    } catch (e) {
      // Xử lý nếu có lỗi xảy ra
      print('Error getting hotels: $e');
      return {};
    }
  }
}
