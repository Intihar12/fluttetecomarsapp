import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FavouriteItem {
  int? productStoreId;
  int? storeId;
  String? title;
  String? image;
  String? price;
  String? discount;
  String? discountPrice;
  String? unit;
  String? itemsPerUnit;
  String? minOrder;
  String? is18plus;
  int? stock;
  RxInt itemCount = 0.obs;

  FavouriteItem({
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
  });

  factory FavouriteItem.fromJson(Map<String, dynamic> jsonData) {
    return FavouriteItem(
      productStoreId: jsonData['product_store_id'] as int?,
      storeId: jsonData['store_id'] as int?,
      title: jsonData['title'] as String?,
      image: jsonData['image'] as String?,
      price: jsonData['price'] as String?,
      discount: jsonData['discount'] as String?,
      discountPrice: jsonData['discount_price'] as String?,
      unit: jsonData['unit'] as String?,
      itemsPerUnit: jsonData['items_per_unit'] as String?,
      minOrder: jsonData['min_order'] as String?,
      is18plus: jsonData['is_18_plus'] as String?,
      stock: jsonData['stock'] as int?,
    );
  }

  static Map<String, dynamic> toMap(FavouriteItem cart) => {
    'product_store_id': cart.productStoreId,
    'store_id': cart.storeId,
    'title': cart.title,
    'image': cart.image,
    'price': cart.price,
    'discount': cart.discount,
    'discount_price': cart.discountPrice,
    'unit': cart.unit,
    'items_per_unit': cart.itemsPerUnit,
    'min_order': cart.minOrder,
    'is_18_plus': cart.is18plus,
    'stock': cart.stock,
  };

  static String encode(List<FavouriteItem> cartItems) => json.encode(
    cartItems
        .map<Map<String, dynamic>>((cart) => FavouriteItem.toMap(cart))
        .toList(),
  );

  static List<FavouriteItem> decode(String cartItems) =>
      (json.decode(cartItems) as List<dynamic>)
          .map<FavouriteItem>((item) => FavouriteItem.fromJson(item))
          .toList();
}