// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) {
  return LoginModel(
    responseCode: json['ResponseCode'] as String?,
    responseMessage: json['ResponseMessage'] as String?,
    response: json['Response'] == null
        ? null
        : Response.fromJson(json['Response'] as Map<String, dynamic>),
    errors: json['errors'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'ResponseMessage': instance.responseMessage,
      'Response': instance.response,
      'errors': instance.errors,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    id: json['id'] as String?,
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    token: json['token'] as String?,
    referCode: json['refer_code'] as String?,
    coin: json['coins'] as String?,
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'token': instance.token,
      'refer_code': instance.referCode,
      'coins': instance.coin,
    };
