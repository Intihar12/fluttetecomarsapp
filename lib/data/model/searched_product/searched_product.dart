

import 'package:kiwkemart/data/model/category_product/category_product.dart';

class SearchedProducts {
  SearchedProducts({
     this.responseCode,
     this.responseMessage,
     this.response,
     this.errors,
  });
   String? responseCode;
   String? responseMessage;
   Response? response;
   List<String>? errors;

  SearchedProducts.fromJson(Map<String, dynamic> json){
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
     this.imagesUrl,
     this.products,
  });
   String? imagesUrl;
   List<Product>? products;

  Response.fromJson(Map<String, dynamic> json){
    imagesUrl = json['images_url'];
    products = List.from(json['products']).map((e)=>Product.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['images_url'] = imagesUrl;
    _data['products'] = products!.map((e)=>e.toJson()).toList();
    return _data;
  }
}
