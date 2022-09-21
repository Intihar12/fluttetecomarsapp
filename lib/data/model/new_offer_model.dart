// To parse this JSON data, do
//
//     final newOffersModel = newOffersModelFromJson(jsonString);

import 'dart:convert';

NewOffersModel newOffersModelFromJson(String str) => NewOffersModel.fromJson(json.decode(str));

class NewOffersModel {
  NewOffersModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  Response? response;
  List<dynamic>? errors;

  factory NewOffersModel.fromJson(Map<String, dynamic> json) => NewOffersModel(
    responseCode: json["ResponseCode"],
    responseMessage: json["ResponseMessage"],
    response: Response.fromJson(json["Response"]),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
  );

}

class Response {
  Response({
    this.id,
    this.title,
    this.body,
    this.active,
  });

  int? id;
  String? title;
  String? body;
  String? active;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    active: json["active"],
  );

}
