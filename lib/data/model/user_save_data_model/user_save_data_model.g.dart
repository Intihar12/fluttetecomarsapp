// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_save_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataSaveModel _$UserDataSaveModelFromJson(Map<String, dynamic> json) {
  return UserDataSaveModel(
    userId: json['user_id'] as String?,
    userName: json['user_name'] as String?,
    userEmail: json['user_email'] as String?,
    userPhone: json['user_phone'] as String?,
    token: json['token'] as String?,
    referCode: json['refer_code'] as String?,
    coin: json['coins'] as String?,
  );
}

Map<String, dynamic> _$UserDataSaveModelToJson(UserDataSaveModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_email': instance.userEmail,
      'user_phone': instance.userPhone,
      'token': instance.token,
      'refer_code': instance.referCode,
      'coins': instance.coin,
    };
