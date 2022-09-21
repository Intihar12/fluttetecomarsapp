import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_product.g.dart';

@JsonSerializable()
class CategoryProduct {
  CategoryProduct({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  @JsonKey(name: 'ResponseCode')
  String? responseCode;
  @JsonKey(name: 'ResponseMessage')
  String? responseMessage;
  @JsonKey(name: 'Response')
  Response? response;
  @JsonKey(name: 'errors')
  List<String>? errors;

  factory CategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$CategoryProductFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryProductToJson(this);
}

@JsonSerializable()
class Response {

  Response({
    this.imagesUrl,
    this.categories
  });

  @JsonKey(name: 'images_url')
  String? imagesUrl;
  @JsonKey(name: 'categories')
  Category? categories;


  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);

}

@JsonSerializable()
class Category {
  Category({
    this.id,
    this.name,
    this.subCategories
  });

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'sub_categories')
  List<SubCat>? subCategories;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}


@JsonSerializable()
class SubCat {
  SubCat({
    this.id,
    this.name,
    this.products,
  });

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'products')
  List<Product>? products;

  factory SubCat.fromJson(Map<String, dynamic> json) =>
      _$SubCatFromJson(json);

  Map<String, dynamic> toJson() => _$SubCatToJson(this);

}

@JsonSerializable()
class Product {
  Product({
    this.productStoreId,
    this.storeId,
    this.title,
    this.image,
    this.price,
    this.discount,
    this.discountPrice,
    this.unit,
    this.itemsPerUnit,
    this.minOrder,
    this.is18plus,
    this.stock,
    required this.itemCount,
    required this.isFav,
  });


  @JsonKey(name: 'product_store_id')
  int? productStoreId;
  @JsonKey(name: 'store_id')
  int? storeId;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'price')
  String? price;
  @JsonKey(name: 'discount')
  String? discount;
  @JsonKey(name: 'discount_price')
  String? discountPrice;
  @JsonKey(name: 'unit')
  String? unit;
  @JsonKey(name: 'items_per_unit')
  String? itemsPerUnit;
  @JsonKey(name: 'min_order')
  String? minOrder;
  @JsonKey(name: 'is_18_plus')
  String? is18plus;
  @JsonKey(name: 'stock')
  int? stock;
  RxInt itemCount = 0.obs;
  RxBool isFav = false.obs;
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);


}
