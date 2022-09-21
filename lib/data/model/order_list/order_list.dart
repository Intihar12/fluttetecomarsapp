class OrderList {
  OrderList({
     this.responseCode,
     this.responseMessage,
     this.response,
     this.errors,
  });
   String? responseCode;
   String? responseMessage;
   Response? response;
   List<String>? errors;

  OrderList.fromJson(Map<String, dynamic> json){
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
     this.imageUrl,
     this.orders,
  });
   String? imageUrl;
   List<Orders>? orders;

  Response.fromJson(Map<String, dynamic> json){
    imageUrl = json['image_url'];
    orders = List.from(json['orders']).map((e)=>Orders.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_url'] = imageUrl;
    _data['orders'] = orders!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Orders {
  Orders({
     this.id,
     this.orderNo,
     this.orderItems,
     this.orderType,
     this.scheduleDate,
     this.status,
     this.total,
  });
   int? id;
   String? orderNo;
   int? orderItems;
   String? orderType;
   String? scheduleDate;
   String? status;
   String? total;

  Orders.fromJson(Map<String, dynamic> json){
    id = json['id'];
    orderNo = json['order_no'];
    orderItems = json['order_items'];
    orderType = json['order_type'];
    scheduleDate = json['schedule_date'];
    status = json['status'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_no'] = orderNo;
    _data['order_items'] = orderItems;
    _data['order_type'] = orderType;
    _data['schedule_date'] = scheduleDate;
    _data['status'] = status;
    _data['total'] = total;
    return _data;
  }
}