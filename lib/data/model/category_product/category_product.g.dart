// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryProduct _$CategoryProductFromJson(Map<String, dynamic> json) {
  return CategoryProduct(
    responseCode: json['ResponseCode'] as String?,
    responseMessage: json['ResponseMessage'] as String?,
    response: json['Response'] == null
        ? null
        : Response.fromJson(json['Response'] as Map<String, dynamic>),
    errors:
    (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$CategoryProductToJson(CategoryProduct instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'ResponseMessage': instance.responseMessage,
      'Response': instance.response,
      'errors': instance.errors,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    imagesUrl: json['images_url'] as String?,
    categories: json['categories'] == null
        ? null
        : Category.fromJson(json['categories'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
  'images_url': instance.imagesUrl,
  'categories': instance.categories,
};

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as int?,
    name: json['name'] as String?,
    subCategories: (json['sub_categories'] as List<dynamic>?)
        ?.map((e) => SubCat.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sub_categories': instance.subCategories,
};

SubCat _$SubCatFromJson(Map<String, dynamic> json) {
  return SubCat(
    id: json['id'] as int?,
    name: json['name'] as String?,
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SubCatToJson(SubCat instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'products': instance.products,
};

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
      productStoreId: json['product_store_id'] as int?,
      storeId: json['store_id'] as int?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      price: json['price'] as String?,
      discount: json['discount'] as String?,
      discountPrice: json['discount_price'] as String?,
      unit: json['unit'] as String?,
      itemsPerUnit: json['items_per_unit'] as String?,
      minOrder: json['min_order'] as String?,
      is18plus: json['is_18_plus'] as String?,
      stock: json['stock'] as int?,
      itemCount: 0.obs,
      isFav: false.obs
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'product_store_id': instance.productStoreId,
  'store_id': instance.storeId,
  'title': instance.title,
  'image': instance.image,
  'price': instance.price,
  'discount': instance.discount,
  'discount_price': instance.discountPrice,
  'unit': instance.unit,
  'items_per_unit': instance.itemsPerUnit,
  'min_order': instance.minOrder,
  'is_18_plus': instance.is18plus,
  'stock': instance.stock,
  'itemCount': instance.itemCount
};
