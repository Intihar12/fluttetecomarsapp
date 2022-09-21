class Voucher {
  Voucher({
     this.responseCode,
     this.responseMessage,
     this.response,
     this.errors,
  });
   String? responseCode;
   String? responseMessage;
   Response? response;
   List<String>? errors;

  Voucher.fromJson(Map<String, dynamic> json){
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
     this.id,
     this.voucherCode,
     this.voucherDiscount,
  });
   int? id;
   String? voucherCode;
   String? voucherDiscount;

  Response.fromJson(Map<String, dynamic> json){
    id = json['id'];
    voucherCode = json['voucher_code'];
    voucherDiscount = json['voucher_discount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['voucher_code'] = voucherCode;
    _data['voucher_discount'] = voucherDiscount;
    return _data;
  }
}