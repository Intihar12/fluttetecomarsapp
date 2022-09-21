// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_store_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveStoreData _$SaveStoreDataFromJson(Map<String, dynamic> json) {
  return SaveStoreData(
    id: json['id'] as int?,
    name: json['name'] as String?,
    lat: json['latitude'] as String?,
    lng: json['longitude'] as String?,
    address: json['address'] as String?,
  );
}

Map<String, dynamic> _$SaveStoreDataToJson(SaveStoreData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.lat,
      'longitude': instance.lng,
      'address': instance.address,
    };
