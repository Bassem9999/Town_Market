class SalesModel {
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? order;
  String? quantity;
  String? time;
  String? totalPrice;
  String? paymentStatus;
  String? status;

  SalesModel(
      this.customerName,
      this.customerPhone,
      this.customerAddress,
      this.order,
      this.quantity,
      this.time,
      this.totalPrice,
      this.paymentStatus,
      this.status);

  SalesModel.fromJson(Map<String, dynamic> json) {
    customerName = json['name'];
    customerPhone = json['mobile'];
    customerAddress = json['address'];
    order = json['order'];
    quantity = json['quantity'];
    time = json['time'];
    totalPrice = json['totalPrice'];
    paymentStatus = json['paymentStatus'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': customerName,
      'mobile': customerPhone,
      'address': customerAddress,
      'order': order,
      'quantity': quantity,
      'time': time,
      'totalPrice': totalPrice,
      'paymentStatus': paymentStatus,
      'status': status
    };
  }
}
