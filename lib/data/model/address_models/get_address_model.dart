

import 'package:json_annotation/json_annotation.dart';
part 'get_address_model.g.dart';

@JsonSerializable()
class GetAddressModel {
  GetAddressModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  @JsonKey(name: "ResponseCode")
  String ? responseCode;
  @JsonKey(name: "ResponseMessage")
  String ?responseMessage;
  @JsonKey(name: "Response")
  List<Response> ? response;
  @JsonKey(name: "errors")
  List<dynamic> ? errors;

  factory GetAddressModel.fromJson(Map<String, dynamic> json) =>
      _$GetAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAddressModelToJson(this);
}

@JsonSerializable()
class Response {
  Response({
    this.id,
    this.title,
    this.address,
    this.latitude,
    this.longitude,
    this.flat,
    this.postalCode,
    this.city
  });

  int ? id;
  String ? title;
  String  ? address;
  String ? latitude;
  String ? longitude;
  String ? city;
  @JsonKey(name: "flat_no")
  String ? flat;
  @JsonKey(name: "postal_code")
  String ? postalCode;


  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);

}
