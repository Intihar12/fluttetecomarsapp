



import 'package:json_annotation/json_annotation.dart';

part 'guest_user_model.g.dart';

@JsonSerializable()


class GuestUser {
  GuestUser({
    required this.responseCode,
    required this.responseMessage,
    this.response,
    this.errors,
  });
  @JsonKey(name: 'ResponseCode')
  String responseCode;
  @JsonKey(name: 'ResponseMessage')
  String responseMessage;
  @JsonKey(name: 'Response')
  Response? response;
  @JsonKey(name: 'errors')
  List<dynamic> ?errors;


  factory GuestUser.fromJson(Map<String, dynamic> json) =>
      _$GuestUserFromJson(json);
  Map<String, dynamic> toJson() => _$GuestUserToJson(this);



}


@JsonSerializable()

class Response {
  Response({
    this.store,
    this.banners,
    this.featuredProduct,
    this.categories,
  });
  @JsonKey(name: 'store')
  Store ?store;
  @JsonKey(name: 'banners')
  List<Banner>? banners;
  @JsonKey(name: 'featuredProduct')
  List<FeaturedProduct>? featuredProduct;
  @JsonKey(name: 'categories')
  List<Category> ?categories;


  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);


}



@JsonSerializable()
class Banner {
  Banner({
    required this.title,
    required this.image,
  });

  @JsonKey(name: 'title')

  String title;
  @JsonKey(name: 'image')

  String image;

  factory Banner.fromJson(Map<String, dynamic> json) =>
      _$BannerFromJson(json);
  Map<String, dynamic> toJson() => _$BannerToJson(this);


}


@JsonSerializable()
class Category {
  Category({
    required this.id,
    required this.name,
     this.subCategories,
  });

  int id;
  String name;
  @JsonKey(name: 'sub_categories')
  List<SubCategory>? subCategories;


  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

}
@JsonSerializable()
class SubCategory {
  SubCategory({
    required this.id,
    required this.parentId,
    required this.name,
    this.image,
    this.backgroundColor,
  });

  int id;
  @JsonKey(name: 'parent_id')
  int parentId;
  String name;
  dynamic image;
  @JsonKey(name: 'background_color')

  dynamic backgroundColor;


  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);

}

@JsonSerializable()

class FeaturedProduct {
  FeaturedProduct({
    required this.productStoreId,
    required this.title,
    required this.image,
    this.unit,
    this.itemsPerUnit,
    required this.price,
    this.minOrder,
  });
  @JsonKey(name: 'product_store_id')
  int productStoreId;

  String title;
  String image;
  String? unit;
  @JsonKey(name: 'items_per_unit')
  String? itemsPerUnit;
  int price;
  @JsonKey(name: 'min_order')
  int? minOrder;

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) =>
      _$FeaturedProductFromJson(json);
  Map<String, dynamic> toJson() => _$FeaturedProductToJson(this);


}



@JsonSerializable()
class Store {
  Store({
    required this.id,
    required this.name,
     this.logo,
    this.imageUrl,
    this.openingClosingTime,
    this.distance,
  });

  int id;
  String name;
  String ?logo;
  @JsonKey(name: 'image_url')
  String ?imageUrl;
  @JsonKey(name: 'opening_Closing_time')
  String ?openingClosingTime;
  int ?distance;

  factory Store.fromJson(Map<String, dynamic> json) =>
      _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);

}
