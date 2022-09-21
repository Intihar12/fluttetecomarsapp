import 'dart:convert';

FavouriteListEmpty favouriteListEmptyFromJson(String str) => FavouriteListEmpty.fromJson(json.decode(str));

String favouriteListEmptyToJson(FavouriteListEmpty data) => json.encode(data.toJson());

class FavouriteListEmpty {
  FavouriteListEmpty({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ?responseCode;
  String ?responseMessage;
  Response ?response;
  List<dynamic>? errors;

  factory FavouriteListEmpty.fromJson(Map<String, dynamic> json) => FavouriteListEmpty(
    responseCode: json["ResponseCode"],
    responseMessage: json["ResponseMessage"],
    response: Response.fromJson(json["Response"]),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
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
