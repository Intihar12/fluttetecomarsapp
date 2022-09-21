
import 'dart:convert';

CartEmpty cartEmptyFromJson(String str) => CartEmpty.fromJson(json.decode(str));

String cartEmptyToJson(CartEmpty data) => json.encode(data.toJson());

class CartEmpty {
  CartEmpty({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  Response? response;
  List<String>? errors;

  factory CartEmpty.fromJson(Map<String, dynamic> json) => CartEmpty(
    responseCode: json["ResponseCode"],
    responseMessage: json["ResponseMessage"],
    response: Response.fromJson(json["Response"]),
    errors: List<String>.from(json["errors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ResponseCode": responseCode,
    "ResponseMessage": responseMessage,
    "Response": response!.toJson(),
    "errors": List<dynamic>.from(errors!.map((x) => x)),
  };
}

class Response {
  Response();

  factory Response.fromJson(Map<String, dynamic> json) => Response(
  );

  Map<String, dynamic> toJson() => {
  };
}
