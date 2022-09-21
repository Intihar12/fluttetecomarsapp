
import 'package:json_annotation/json_annotation.dart';
part 'payment_card_model.g.dart';

@JsonSerializable()
class GetCardListModel {
  GetCardListModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });
  @JsonKey(name: "ResponseCode")
  String ? responseCode;
  @JsonKey(name: "ResponseMessage")
  String ? responseMessage;
  @JsonKey(name: "Response")
  Response ? response;
  @JsonKey(name: "errors")
  List<dynamic> ? errors;


  factory GetCardListModel.fromJson(Map<String, dynamic> json) =>
      _$GetCardListModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCardListModelToJson(this);
}

@JsonSerializable()
class Response {
  Response({
    this.defaultCard,
    this.otherCards,
  });
  @JsonKey(name: "default_card")
  Card ? defaultCard;
  @JsonKey(name: "other_cards")
  List<Card> ? otherCards;

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

@JsonSerializable()
class Card {
  Card({
    this.pmId,
    this.cardType,
    this.last4Digit,
  });

  @JsonKey(name: "pm_id")
  String ? pmId;
  @JsonKey(name: "card_type")
  String ? cardType;
  @JsonKey(name: "last4digit")
  String  ? last4Digit;

  factory Card.fromJson(Map<String, dynamic> json) =>
      _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
