import 'package:json_annotation/json_annotation.dart';
import 'package:kiwkemart/data/model/category_product/category_product.dart';
part 'home_data.g.dart';

@JsonSerializable()
class HomeData {
  HomeData({
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

  factory HomeData.fromJson(Map<String, dynamic> json) =>
      _$HomeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDataToJson(this);
}

@JsonSerializable()
class Response {
  Response({
    this.imagesUrl,
    this.store,
    this.banners,
    this.featuredProduct,
    this.categories,
  });
  @JsonKey(name: 'images_url')
  String? imagesUrl;
  @JsonKey(name: 'store')
  Store? store;
  @JsonKey(name: 'banners')
  List<Banners>? banners;
  @JsonKey(name: 'featuredProduct')
  List<Product>? featuredProduct;
  @JsonKey(name: 'categories')
  List<Categories>? categories;
  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

@JsonSerializable()
class Store {
  Store({
    this.id,
    this.name,
    this.logo,
    this.imageUrl,
    this.openingClosingTime,
    this.distance,
    this.serviceFee,
    this.deliveryFee,
    this.address,
    this.lat,
    this.lng,
  });
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'logo')
  String? logo;
  @JsonKey(name: 'address')
  String ? address;
  @JsonKey(name: 'latitude')
  String ? lat;
  @JsonKey(name: 'longitude')
  String ?lng;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'opening_Closing_time')
  String? openingClosingTime;
  @JsonKey(name: 'distance')
  String ? distance;
  @JsonKey(name: 'service_fee')
  String? serviceFee;
  @JsonKey(name: 'delivery_fee')
  String? deliveryFee;

  factory Store.fromJson(Map<String, dynamic> json) =>
      _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}

@JsonSerializable()
class Banners {
  Banners({
    this.title,
    this.image,
  });
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'image')
  String? image;

  factory Banners.fromJson(Map<String, dynamic> json) =>
      _$BannersFromJson(json);
  Map<String, dynamic> toJson() => _$BannersToJson(this);
}


@JsonSerializable()
class Categories {
  Categories({
    this.id,
    this.name,
    this.subCategories,
  });
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'sub_categories')
  List<SubCategories>? subCategories;

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}

@JsonSerializable()
class SubCategories {
  SubCategories({
    this.id,
    this.parentId,
    this.name,
    this.backgroundColor,
    this.image,
  });
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'parent_id')
  int? parentId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'background_color')
  String? backgroundColor;
  @JsonKey(name: 'image')
  String? image;

  factory SubCategories.fromJson(Map<String, dynamic> json) =>
      _$SubCategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoriesToJson(this);
}