import 'package:json_annotation/json_annotation.dart';
import 'package:kiwkemart/data/model/category_product/category_product.dart';

part 'product_details.g.dart';

@JsonSerializable()
class ProductDetailModel {
  ProductDetailModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });
  @JsonKey(name: "ResponseCode")
  String? responseCode;
  @JsonKey(name: "ResponseMessage")
  String? responseMessage;
  @JsonKey(name: "Response")
  Response? response;
  @JsonKey(name: "errors")
  List<dynamic>? errors;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);

}

@JsonSerializable()
class Response {
  Response({
     this.imagesUrl,
     this.productDetail,
    this.otherProducts,
  });
  @JsonKey(name: "images_url")
  String? imagesUrl;
  @JsonKey(name: "product_detail")
  ProductDetail? productDetail;
  @JsonKey(name: "other_products")
  List<Product>? otherProducts;

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);

}

// @JsonSerializable()
// class OtherProduct {
//   OtherProduct({
//     required this.productStoreId,
//     required this.storeId,
//     required this.title,
//     required this.image,
//     required this.unit,
//     required this.itemsPerUnit,
//     required this.price,
//     required this.minOrder,
//     this.discount,
//     this.discountPrice,
//      this.stock,
//     this.is18Plus,
//   });
//   @JsonKey(name: "product_store_id")
//   int productStoreId;
//   @JsonKey(name: "store_id")
//   int storeId;
//   @JsonKey(name: "title")
//   String title;
//   @JsonKey(name: "image")
//   String image;
//   @JsonKey(name: "unit")
//   String unit;
//   @JsonKey(name: "items_per_unit")
//   String itemsPerUnit;
//   @JsonKey(name: "price")
//   String price;
//   @JsonKey(name: "min_order")
//   int minOrder;
//   @JsonKey(name: "discount")
//   String ? discount;
//   @JsonKey(name: "discount_price")
//   String ? discountPrice;
//   @JsonKey(name: "stock")
//   int ? stock;
//   @JsonKey(name: "is_18_plus")
//   int ? is18Plus;
//
//
//
//   factory OtherProduct.fromJson(Map<String, dynamic> json) =>
//       _$OtherProductFromJson(json);
//
//   Map<String, dynamic> toJson() => _$OtherProductToJson(this);
//
// }

@JsonSerializable()
class ProductDetail {
  ProductDetail({
    this.productStoreId,
    this.title,
    this.image,
    this.price,
    this.discount,
    this.discountPrice,
    this.unit,
    this.itemsPerUnit,
    this.minOrder,
    this.stock,
    this.is18Plus,
    this.description,
    this.ingredients,
    this.allergenInformation,
    this.countryOfOrigin,
    this.manufacturer,
    this.storageConditions,
    this.expirationDate,
    this.disclaimer,
    this.tags,
    this.nutrition,
  });

  @JsonKey(name: "product_store_id")
  int? productStoreId;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "discount")
   String? discount;
  @JsonKey(name: "discount_price")
  String? discountPrice;
  @JsonKey(name: "unit")
  String? unit;
  @JsonKey(name: "items_per_unit")
  String? itemsPerUnit;
  @JsonKey(name:"min_order")
  String? minOrder;
  @JsonKey(name: "stock")
  int? stock;
  @JsonKey(name: "is_18_plus")
  String? is18Plus;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "ingredients")
  String? ingredients;
  @JsonKey(name: "allergen_information")
  String? allergenInformation;
  @JsonKey(name: "country_of_origin")
  String? countryOfOrigin;
  @JsonKey(name: "manufacturer")
  String? manufacturer;
  @JsonKey(name: "storage_conditions")
  String? storageConditions;
  @JsonKey(name: "expiration_date")
  String? expirationDate;
  @JsonKey(name: "disclaimer")
  String? disclaimer;
  @JsonKey(name: "tags")
  List<Tag>? tags;
  @JsonKey(name: "nutrition")
  List<Nutrition>? nutrition;

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);

}

@JsonSerializable()
class Nutrition {
  Nutrition({
    this.typicalValues,
    this.per100GOfProduct,
    this.riPer100G,
  });
  @JsonKey(name: "typical_values")
  String? typicalValues;
  @JsonKey(name: "per_100g_of_product")
  String? per100GOfProduct;
  @JsonKey(name: "ri_per_100g")
  String? riPer100G;

  factory Nutrition.fromJson(Map<String, dynamic> json) =>
      _$NutritionFromJson(json);

  Map<String, dynamic> toJson() => _$NutritionToJson(this);
}

@JsonSerializable()
class Tag {
  Tag({
     this.name,
     this.icon,
  });

  String? name;
  String? icon;


  factory Tag.fromJson(Map<String, dynamic> json) =>
      _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

}
