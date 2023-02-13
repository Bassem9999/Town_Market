class OrderModel {
  String? id;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? order;
  String? quantity;
  String? time;
  String? totalPrice;
  String? paymentStatus;

  OrderModel(
    this.id,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.order,
    this.quantity,
    this.time,
    this.totalPrice,
    this.paymentStatus,
  );

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['name'];
    customerPhone = json['mobile'];
    customerAddress = json['address'];
    order = json['order'];
    quantity = json['quantity'];
    time = json['time'];
    totalPrice = json['totalPrice'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': customerName,
      'mobile': customerPhone,
      'address': customerAddress,
      'order': order,
      'quantity': quantity,
      'time': time,
      'totalPrice': totalPrice,
      'paymentStatus': paymentStatus,
    };
  }
}
