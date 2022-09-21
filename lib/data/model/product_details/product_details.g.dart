// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) {
  return ProductDetailModel(
    responseCode: json['ResponseCode'] as String?,
    responseMessage: json['ResponseMessage'] as String?,
    response: json['Response'] == null
        ? null
        : Response.fromJson(json['Response'] as Map<String, dynamic>),
    errors: json['errors'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'ResponseMessage': instance.responseMessage,
      'Response': instance.response,
      'errors': instance.errors,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    imagesUrl: json['images_url'] as String?,
    productDetail: json['product_detail'] == null
        ? null
        : ProductDetail.fromJson(
            json['product_detail'] as Map<String, dynamic>),
    otherProducts: (json['other_products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'images_url': instance.imagesUrl,
      'product_detail': instance.productDetail,
      'other_products': instance.otherProducts,
    };

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) {
  return ProductDetail(
    productStoreId: json['product_store_id'] as int?,
    title: json['title'] as String?,
    image: json['image'] as String?,
    price: json['price'] as String?,
    discount: json['discount'] as String?,
    discountPrice: json['discount_price'] as String?,
    unit: json['unit'] as String?,
    itemsPerUnit: json['items_per_unit'] as String?,
    minOrder: json['min_order'] as String?,
    stock: json['stock'] as int?,
    is18Plus: json['is_18_plus'] as String?,
    description: json['description'] as String?,
    ingredients: json['ingredients'] as String?,
    allergenInformation: json['allergen_information'] as String?,
    countryOfOrigin: json['country_of_origin'] as String?,
    manufacturer: json['manufacturer'] as String?,
    storageConditions: json['storage_conditions'] as String?,
    expirationDate: json['expiration_date'] as String?,
    disclaimer: json['disclaimer'] as String?,
    tags: (json['tags'] as List<dynamic>?)
        ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
        .toList(),
    nutrition: (json['nutrition'] as List<dynamic>?)
        ?.map((e) => Nutrition.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'product_store_id': instance.productStoreId,
      'title': instance.title,
      'image': instance.image,
      'price': instance.price,
      'discount': instance.discount,
      'discount_price': instance.discountPrice,
      'unit': instance.unit,
      'items_per_unit': instance.itemsPerUnit,
      'min_order': instance.minOrder,
      'stock': instance.stock,
      'is_18_plus': instance.is18Plus,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'allergen_information': instance.allergenInformation,
      'country_of_origin': instance.countryOfOrigin,
      'manufacturer': instance.manufacturer,
      'storage_conditions': instance.storageConditions,
      'expiration_date': instance.expirationDate,
      'disclaimer': instance.disclaimer,
      'tags': instance.tags,
      'nutrition': instance.nutrition,
    };

Nutrition _$NutritionFromJson(Map<String, dynamic> json) {
  return Nutrition(
    typicalValues: json['typical_values'] as String?,
    per100GOfProduct: json['per_100g_of_product'] as String?,
    riPer100G: json['ri_per_100g'] as String?,
  );
}

Map<String, dynamic> _$NutritionToJson(Nutrition instance) => <String, dynamic>{
      'typical_values': instance.typicalValues,
      'per_100g_of_product': instance.per100GOfProduct,
      'ri_per_100g': instance.riPer100G,
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    name: json['name'] as String?,
    icon: json['icon'] as String?,
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'name': instance.name,
      'icon': instance.icon,
    };
