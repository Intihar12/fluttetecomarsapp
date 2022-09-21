import 'dart:convert';

class CartItemSave {
  int  productStoreId;
  int  storeId;
  int  quantity;
  String image;
  String unit;
  String title;
  int stock;
  double price;

  CartItemSave({
    required this.productStoreId,
    required this.storeId,
    required this.quantity,
    required this.image,
    required this.unit,
    required this.title,
    required this.stock,
    required this.price,
  });

  factory CartItemSave.fromJson(Map<String, dynamic> jsonData) {
    return CartItemSave(
      productStoreId: jsonData['productStoreId'],
      storeId: jsonData['storeId'],
      quantity: jsonData['quantity'],
      image: jsonData['image'],
      unit: jsonData['unit'],
      title: jsonData['title'],
      stock: jsonData['stock'],
      price: jsonData['price'],
    );
  }

  static Map<String, dynamic> toMap(CartItemSave cart) => {
    'productStoreId': cart.productStoreId,
    'storeId': cart.storeId,
    'quantity': cart.quantity,
    'image': cart.image,
    'unit': cart.unit,
    'title': cart.title,
    'stock': cart.stock,
    'price': cart.price
  };

  static String encode(List<CartItemSave> cartItems) => json.encode(
    cartItems
        .map<Map<String, dynamic>>((cart) => CartItemSave.toMap(cart))
        .toList(),
  );

  static List<CartItemSave> decode(String cartItems) =>
      (json.decode(cartItems) as List<dynamic>)
          .map<CartItemSave>((item) => CartItemSave.fromJson(item))
          .toList();
}