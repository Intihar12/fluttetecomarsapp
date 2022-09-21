// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAddressModel _$GetAddressModelFromJson(Map<String, dynamic> json) {
  return GetAddressModel(
    responseCode: json['ResponseCode'] as String?,
    responseMessage: json['ResponseMessage'] as String?,
    response: (json['Response'] as List<dynamic>?)
        ?.map((e) => Response.fromJson(e as Map<String, dynamic>))
        .toList(),
    errors: json['errors'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$GetAddressModelToJson(GetAddressModel instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'ResponseMessage': instance.responseMessage,
      'Response': instance.response,
      'errors': instance.errors,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    id: json['id'] as int?,
    title: json['title'] as String?,
    address: json['address'] as String?,
    latitude: json['latitude'] as String?,
    longitude: json['longitude'] as String?,
    flat: json['flat_no'] as String?,
    postalCode: json['postal_code'] as String?,
    city: json['city'] as String?,
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'flat_no': instance.flat,
      'postal_code': instance.postalCode,
    };
