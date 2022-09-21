// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeData _$HomeDataFromJson(Map<String, dynamic> json) {
  return HomeData(
    responseCode: json['ResponseCode'] as String?,
    responseMessage: json['ResponseMessage'] as String?,
    response: json['Response'] == null
        ? null
        : Response.fromJson(json['Response'] as Map<String, dynamic>),
    errors:
    (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$HomeDataToJson(HomeData instance) => <String, dynamic>{
  'ResponseCode': instance.responseCode,
  'ResponseMessage': instance.responseMessage,
  'Response': instance.response,
  'errors': instance.errors,
};

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    imagesUrl: json['images_url'] as String?,
    store: json['store'] == null
        ? null
        : Store.fromJson(json['store'] as Map<String, dynamic>),
    banners: (json['banners'] as List<dynamic>?)
        ?.map((e) => Banners.fromJson(e as Map<String, dynamic>))
        .toList(),
    featuredProduct: (json['featuredProduct'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
    categories: (json['categories'] as List<dynamic>?)
        ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
  'images_url': instance.imagesUrl,
  'store': instance.store,
  'banners': instance.banners,
  'featuredProduct': instance.featuredProduct,
  'categories': instance.categories,
};

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    id: json['id'] as int?,
    name: json['name'] as String?,
    logo: json['logo'] as String?,
    address: json['address'] as String?,
    lat: json['latitude'] as String?,
    lng: json['longitude'] as String?,
    imageUrl: json['image_url'] as String?,
    openingClosingTime: json['opening_Closing_time'] as String?,
    distance: json['distance'] as String?,
    serviceFee: json['service_fee'] as String?,
    deliveryFee: json['delivery_fee'] as String?,
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logo': instance.logo,
  'address':instance.address,
  'latitude':instance.lat,
  'longitude':instance.lng,
  'image_url': instance.imageUrl,
  'opening_Closing_time': instance.openingClosingTime,
  'distance': instance.distance,
  'service_fee': instance.serviceFee,
  'delivery_fee': instance.deliveryFee,
};

Banners _$BannersFromJson(Map<String, dynamic> json) {
  return Banners(
    title: json['title'] as String?,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$BannersToJson(Banners instance) => <String, dynamic>{
  'title': instance.title,
  'image': instance.image,
};

Categories _$CategoriesFromJson(Map<String, dynamic> json) {
  return Categories(
    id: json['id'] as int?,
    name: json['name'] as String?,
    subCategories: (json['sub_categories'] as List<dynamic>?)
        ?.map((e) => SubCategories.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sub_categories': instance.subCategories,
    };

SubCategories _$SubCategoriesFromJson(Map<String, dynamic> json) {
  return SubCategories(
    id: json['id'] as int?,
    parentId: json['parent_id'] as int?,
    name: json['name'] as String?,
    backgroundColor: json['background_color'] as String?,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$SubCategoriesToJson(SubCategories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parentId,
      'name': instance.name,
      'background_color': instance.backgroundColor,
      'image': instance.image,
    };
