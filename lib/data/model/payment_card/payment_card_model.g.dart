// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCardListModel _$GetCardListModelFromJson(Map<String, dynamic> json) {
  return GetCardListModel(
    responseCode: json['ResponseCode'] as String?,
    responseMessage: json['ResponseMessage'] as String?,
    response: json['Response'] == null
        ? null
        : Response.fromJson(json['Response'] as Map<String, dynamic>),
    errors: json['errors'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$GetCardListModelToJson(GetCardListModel instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'ResponseMessage': instance.responseMessage,
      'Response': instance.response,
      'errors': instance.errors,
    };

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
    defaultCard: json['default_card'] == null
        ? null
        : Card.fromJson(json['default_card'] as Map<String, dynamic>),
    otherCards: (json['other_cards'] as List<dynamic>?)
        ?.map((e) => Card.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'default_card': instance.defaultCard,
      'other_cards': instance.otherCards,
    };

Card _$CardFromJson(Map<String, dynamic> json) {
  return Card(
    pmId: json['pm_id'] as String?,
    cardType: json['card_type'] as String?,
    last4Digit: json['last4digit'] as String?,
  );
}

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'pm_id': instance.pmId,
      'card_type': instance.cardType,
      'last4digit': instance.last4Digit,
    };
