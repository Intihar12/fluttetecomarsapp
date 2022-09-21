



import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()

class LoginModel {
  LoginModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors
  });
  @JsonKey(name: 'ResponseCode')
  String? responseCode;
  @JsonKey(name: 'ResponseMessage')
  String? responseMessage;
  @JsonKey(name: 'Response')
  Response? response;
  @JsonKey(name: 'errors')
  List<dynamic>? errors;

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);


}


@JsonSerializable()
class Response {
  Response({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.token,
    this.referCode,
    this.coin,
  });
  @JsonKey(name: 'id')
  String ?id;
  @JsonKey(name: 'first_name')
  String ?firstName;
  @JsonKey(name: 'last_name')
  String ?lastName;
  @JsonKey(name: 'email')
  String ?email;
  @JsonKey(name: 'phone')
  String ?phone;
  @JsonKey(name: 'token')
  String ?token;
  @JsonKey(name: 'refer_code')
  String ? referCode;
  @JsonKey(name: 'coins')
  String ? coin;

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}





