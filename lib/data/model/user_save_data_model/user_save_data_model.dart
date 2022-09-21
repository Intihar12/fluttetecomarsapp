
import 'package:json_annotation/json_annotation.dart';

part 'user_save_data_model.g.dart';

@JsonSerializable()
class UserDataSaveModel
{
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'user_email')
  String? userEmail;
  @JsonKey(name: 'user_phone')
  String? userPhone;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'refer_code')
  String ? referCode;
  @JsonKey(name: 'coins')
  String ? coin;

  UserDataSaveModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.token,
    this.referCode,
    this.coin
  });

  factory UserDataSaveModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataSaveModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataSaveModelToJson(this);

}