// To parse this JSON data, do
//
//     final storeLocation = storeLocationFromJson(jsonString);

import 'dart:convert';

StoreLocation storeLocationFromJson(String str) => StoreLocation.fromJson(json.decode(str));

String storeLocationToJson(StoreLocation data) => json.encode(data.toJson());

class StoreLocation {
  StoreLocation({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  Response? response;
  List<dynamic>? errors;

  factory StoreLocation.fromJson(Map<String, dynamic> json) => StoreLocation(
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
    this.id,
    this.name,
    this.logo,
    this.imageUrl,
    this.openingClosingTime,
    this.address,
    this.latitude,
    this.longitude,
    this.distance,
  });

  int ?id;
  String? name;
  String ?logo;
  String ?imageUrl;
  String ?openingClosingTime;
  String ?address;
  String ?latitude;
  String ?longitude;
  String ?distance;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    imageUrl: json["image_url"],
    openingClosingTime: json["opening_Closing_time"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "image_url": imageUrl,
    "opening_Closing_time": openingClosingTime,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "distance": distance,
  };
}
