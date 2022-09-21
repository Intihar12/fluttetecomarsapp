// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SaveAddressModel  saveAddressModelFromJson(String str) => SaveAddressModel .fromJson(json.decode(str));

String saveAddressModelToJson(SaveAddressModel  data) => json.encode(data.toJson());

class SaveAddressModel {
  SaveAddressModel ({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String ? responseCode;
  String ?responseMessage;
  Response? response;
  List<dynamic>? errors;

  factory SaveAddressModel.fromJson(Map<String, dynamic> json) => SaveAddressModel(
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
  Response({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.address,
    this.city,
    this.flatNo,
    required this.postalCode,
  });

  int id;
  String userId;
  String latitude;
  String longitude;
  String title;
  String address;
  String? city;
  String? flatNo;
  String postalCode;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    userId: json["user_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    title: json["title"],
    address: json["address"],
    city: json["city"],
    flatNo: json["flat_no"],
    postalCode: json["postal_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "latitude": latitude,
    "longitude": longitude,
    "title": title,
    "address": address,
    "city": city,
    "flat_no": flatNo,
    "postal_code": postalCode,
  };
}
