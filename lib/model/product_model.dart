class ProductModel {
  String? productName;
  String? productOldPrice;
  String? productNewPrice;
  String? discount;
  String? productCategory;
  String? productImage;

  ProductModel(this.productName, this.productOldPrice, this.productNewPrice,
      this.discount, this.productCategory, this.productImage);

  ProductModel.fromJson(Map<String, dynamic> json) {
    productName = json['name'];
    productOldPrice = json['oldPrice'];
    productNewPrice = json['newPrice'];
    discount = json['discount'];
    productCategory = json['category'];
    productImage = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': productName,
      'oldPrice': productOldPrice,
      'newPrice': productNewPrice,
      'discount': discount,
      'category': productCategory,
      'imageUrl': productImage,
    };
  }
}
