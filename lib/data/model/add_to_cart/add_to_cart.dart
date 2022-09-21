import '../category_product/category_product.dart';

class AddToCart {
  AddToCart({
     this.responseCode,
     this.responseMessage,
     this.response,
     this.errors,
  });
   String? responseCode;
   String? responseMessage;
   Response? response;
   List<String>? errors;

  AddToCart.fromJson(Map<String, dynamic> json){

    responseCode = json['ResponseCode'];
    responseMessage = json['ResponseMessage'];
    response = Response.fromJson(json['Response']);
    errors = List.castFrom<dynamic, String>(json['errors']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ResponseCode'] = responseCode;
    _data['ResponseMessage'] = responseMessage;
    _data['Response'] = response!.toJson();
    _data['errors'] = errors;
    return _data;
  }
}

class Response {
  Response({
     this.products,
    this.callAtDoor,
    this.ringBell
  });

   List<Products>? products;
   String? total;
   String ?baseUrl;
  String? callAtDoor;
  String? ringBell;

  Response.fromJson(Map<String, dynamic> json){
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
    total = json['total'];
    baseUrl=json['base_url'];
    callAtDoor = json["call_at_door"];
    ringBell = json["ring_bell"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products!.map((e)=>e.toJson()).toList();
    _data['total'] = total;
    _data['base_url']=baseUrl;
    return _data;
  }
}

class Products {
  Products({
     this.productStoreId,
     this.quantity,
     this.price,
     this.isDeleted,
     this.isQuantityChanged,
     this.isPriceChanged,
  });
   int? productStoreId;
   int? quantity;
   String? price;
   int? isDeleted;
   int? isQuantityChanged;
   int? isPriceChanged;
  Product? product;
  Products.fromJson(Map<String, dynamic> json){
    productStoreId = json['product_store_id'];
    quantity = json['quantity'];
    price = json['price'];
    isDeleted = json['is_deleted'];
    isQuantityChanged = json['is_quantity_changed'];
    isPriceChanged = json['is_price_changed'];
    product=Product. fromJson(json['product']);;

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_store_id'] = productStoreId;
    _data['quantity'] = quantity;
    _data['price'] = price;
    _data['is_deleted'] = isDeleted;
    _data['is_quantity_changed'] = isQuantityChanged;
    _data['is_price_changed'] = isPriceChanged;
    _data['product']=product!.toJson();
    return _data;
  }
}