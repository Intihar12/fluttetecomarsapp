// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestUser _$GuestUserFromJson(Map<String, dynamic> json) {
  return GuestUser(
    responseCode: json['ResponseCode'] as String,
    responseMessage: json['ResponseMessage'] as String,
    response: json['Response'] == null
        ? null
        : Response.fromJson(json['Response'] as Map<String, dynamic>),
    errors: json['errors'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$GuestUserToJson(GuestUser instance) => <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'ResponseMessage': instance.responseMessage,
      'Response': instance.response,
      'errors': instance.errors,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    store: json['store'] == null
        ? null
        : Store.fromJson(json['store'] as Map<String, dynamic>),
    banners: (json['banners'] as List<dynamic>?)
        ?.map((e) => Banner.fromJson(e as Map<String, dynamic>))
        .toList(),
    featuredProduct: (json['featuredProduct'] as List<dynamic>?)
        ?.map((e) => FeaturedProduct.fromJson(e as Map<String, dynamic>))
        .toList(),
    categories: (json['categories'] as List<dynamic>?)
        ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'store': instance.store,
      'banners': instance.banners,
      'featuredProduct': instance.featuredProduct,
      'categories': instance.categories,
    };

Banner _$BannerFromJson(Map<String, dynamic> json) {
  return Banner(
    title: json['title'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as int,
    name: json['name'] as String,
    subCategories: (json['sub_categories'] as List<dynamic>?)
        ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sub_categories': instance.subCategories,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) {
  return SubCategory(
    id: json['id'] as int,
    parentId: json['parent_id'] as int,
    name: json['name'] as String,
    image: json['image'],
    backgroundColor: json['background_color'],
  );
}

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parentId,
      'name': instance.name,
      'image': instance.image,
      'background_color': instance.backgroundColor,
    };

FeaturedProduct _$FeaturedProductFromJson(Map<String, dynamic> json) {
  return FeaturedProduct(
    productStoreId: json['product_store_id'] as int,
    title: json['title'] as String,
    image: json['image'] as String,
    unit: json['unit'] as String?,
    itemsPerUnit: json['items_per_unit'] as String?,
    price: json['price'] as int,
    minOrder: json['min_order'] as int?,
  );
}

Map<String, dynamic> _$FeaturedProductToJson(FeaturedProduct instance) =>
    <String, dynamic>{
      'product_store_id': instance.productStoreId,
      'title': instance.title,
      'image': instance.image,
      'unit': instance.unit,
      'items_per_unit': instance.itemsPerUnit,
      'price': instance.price,
      'min_order': instance.minOrder,
    };

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    id: json['id'] as int,
    name: json['name'] as String,
    logo: json['logo'] as String?,
    imageUrl: json['image_url'] as String?,
    openingClosingTime: json['opening_Closing_time'] as String?,
    distance: json['distance'] as int?,
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'image_url': instance.imageUrl,
      'opening_Closing_time': instance.openingClosingTime,
      'distance': instance.distance,
    };
