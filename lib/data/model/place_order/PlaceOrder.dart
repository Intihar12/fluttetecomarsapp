

class PlaceOrder {
  PlaceOrder({
     this.responseCode,
     this.responseMessage,
     this.response,
     this.errors,
  });
   String? responseCode;
   String? responseMessage;
   Response? response;
   List<String>? errors;

  PlaceOrder.fromJson(Map<String, dynamic> json){
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
  String? orderNo;
  int? id;
  Response({
    this.id,
    this.orderNo
});
  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    orderNo = json['order_no'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_no'] = orderNo;
    return _data;
  }
}