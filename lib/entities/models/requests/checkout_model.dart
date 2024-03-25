class CheckoutModel {
  final String? uId;
  final String? paymentId;
  final String? totalPrice;
  final String? totalProduct;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? note;
  final String? paymentMethod;
  final DateTime? createdAt;

  CheckoutModel({
    this.uId,
    this.paymentId,
    this.email,
    this.phoneNumber,
    this.address,
    this.note,
    this.paymentMethod,
    this.createdAt,
    this.totalPrice,
    this.totalProduct,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      uId: json['uId'],
      paymentId: json['paymentId'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      note: json['note'],
      paymentMethod: json['paymentMethod'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      totalPrice: json['totalPrice'],
      totalProduct: json['totalProduct'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uId'] = uId;
    data['paymentId'] = paymentId;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['note'] = note;
    data['paymentMethod'] = paymentMethod;
    data['createdAt'] = createdAt?.toIso8601String();
    data['totalPrice'] = totalPrice;
    data['totalProduct'] = totalProduct;
    return data;
  }
}
