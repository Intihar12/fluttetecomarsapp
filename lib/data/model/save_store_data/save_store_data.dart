
import 'package:json_annotation/json_annotation.dart';

part 'save_store_data.g.dart';

@JsonSerializable()

class   SaveStoreData{

  SaveStoreData({
    this.id,
    this.name,
    this.lat,
    this.lng,
    this.address
});
  @JsonKey(name: 'id')
  int ?id;
  @JsonKey(name: 'name')
  String ? name;
  @JsonKey(name: 'latitude')
  String ?lat;
  @JsonKey(name: 'longitude')
  String ?lng;
  @JsonKey(name: 'address')
  String ?address;



  factory SaveStoreData.fromJson(Map<String, dynamic> json) =>
      _$SaveStoreDataFromJson(json);

  Map<String, dynamic> toJson() => _$SaveStoreDataToJson(this);
}