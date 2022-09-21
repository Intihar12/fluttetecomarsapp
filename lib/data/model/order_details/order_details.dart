class OrderDetails {
  OrderDetails({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  Response? response;
  List<String>? errors;

  OrderDetails.fromJson(Map<String, dynamic> json) {
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
    this.order,
  });

  String? imageUrl;
  Order? order;

  Response.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    order = Order.fromJson(json['order']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_url'] = imageUrl;
    _data['order'] = order!.toJson();
    return _data;
  }
}

class Order {
  Order({
    this.orderNo,
    this.voucherCode,
    this.voucherDiscount,
    this.subTotal,
    this.total,
    this.scheduleDate,
    this.callAtDoor,
    this.ringBell,
    this.description,
    this.orderType,
    this.status,
    this.isPaid,
    this.userAddress,
    this.orderItems,
  });

  String? orderNo;
  String? voucherCode;
  String? voucherDiscount;
  String? subTotal;
  String? total;
  String? scheduleDate;
  String? callAtDoor;
  String? ringBell;
  String? description;
  String? orderType;
  String? status;
  String? isPaid;
  UserAddress? userAddress;
  List<OrderItems>? orderItems;

  Order.fromJson(Map<String, dynamic> json) {
    orderNo = json['order_no'];
    voucherCode = null;
    voucherDiscount = null;
    subTotal = json['sub_total'];
    total = json['total'];
    scheduleDate = json['schedule_date'];
    callAtDoor = json['call_at_door'];
    ringBell = json['ring_bell'];
    description = json['description'];
    orderType = json['order_type'];
    status = json['status'];
    isPaid = json['is_paid'];
    userAddress = UserAddress.fromJson(json['user_address']);
    orderItems = List.from(json['order_items'])
        .map((e) => OrderItems.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_no'] = orderNo;
    _data['voucher_code'] = voucherCode;
    _data['voucher_discount'] = voucherDiscount;
    _data['sub_total'] = subTotal;
    _data['total'] = total;
    _data['schedule_date'] = scheduleDate;
    _data['call_at_door'] = callAtDoor;
    _data['ring_bell'] = ringBell;
    _data['description'] = description;
    _data['order_type'] = orderType;
    _data['status'] = status;
    _data['is_paid'] = isPaid;
    _data['user_address'] = userAddress!.toJson();
    _data['order_items'] = orderItems!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class UserAddress {
  UserAddress({
    this.latitude,
    this.longitude,
    this.title,
    this.address,
    this.city,
    this.flatNo,
    this.postalCode,
  });

  String? latitude;
  String? longitude;
  String? title;
  String? address;
  String? city;
  String? flatNo;
  String? postalCode;

  UserAddress.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    title = null;
    address = json['address'];
    city = null;
    flatNo = null;
    postalCode = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['title'] = title;
    _data['address'] = address;
    _data['city'] = city;
    _data['flat_no'] = flatNo;
    _data['postal_code'] = postalCode;
    return _data;
  }
}

class OrderItems {
  OrderItems({
    this.title,
    this.description,
    this.image,
    this.quantity,
    this.price,
    this.total,
  });

  String? title;
  String? description;
  String? image;
  int? quantity;
  String? price;
  String? total;

  OrderItems.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['description'] = description;
    _data['image'] = image;
    _data['quantity'] = quantity;
    _data['price'] = price;
    _data['total'] = total;
    return _data;
  }
}
