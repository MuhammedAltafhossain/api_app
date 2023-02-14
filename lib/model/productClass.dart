

/// responsible for the conversion of json to dart
class ProductListPojo {
  String? status;
  List<Product>? listOfProducts;

  ProductListPojo({this.status, this.listOfProducts});

  ProductListPojo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfProducts = <Product>[];
      json['data'].forEach((v) {
        listOfProducts!.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  String? CreatedDate;
  String? id;
  String? title;
  String? price;
  String? special_price;
  String? image;
  String? category;
  String? subcategory;
  String? remark;
  String? brand;
  String? shop;
  String? shop_name;
  String? star;
  String? product_code;
  String? stock;

  Product({
    this.CreatedDate,
    this.id,
    this.title,
    this.price,
    this.special_price,
    this.image,
    this.category,
    this.subcategory,
    this.remark,
    this.brand,
    this.shop,
    this.shop_name,
    this.star,
    this.product_code,
    this.stock,
  });

  Product.fromJson(Map<String, dynamic> json) {
    CreatedDate = json['CreatedDate'];
    id = json['_id'];
    title = json['title'];
    price = json['price'];
    special_price = json['special_price'];
    image = json['image'];
    category = json['category'];
    subcategory = json['subcategory'];
    remark = json['remark'];
    brand = json['brand'];
    shop = json['shop'];
    shop_name = json['shop_name'];
    star = json['star'];
    product_code = json['product_code'];
    stock = json['stock'];


  }


}
