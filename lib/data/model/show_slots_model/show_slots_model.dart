// To parse this JSON data, do
//
//     final showSlotsModel = showSlotsModelFromJson(jsonString);

import 'dart:convert';

ShowSlotsModel showSlotsModelFromJson(String str) => ShowSlotsModel.fromJson(json.decode(str));

class ShowSlotsModel {
  ShowSlotsModel({
    this.responseCode,
    this.responseMessage,
    this.response,
    this.errors,
  });

  String? responseCode;
  String? responseMessage;
  List<Response>? response;
  List<dynamic>? errors;

  factory ShowSlotsModel.fromJson(Map<String, dynamic> json) => ShowSlotsModel(
    responseCode: json["ResponseCode"],
    responseMessage: json["ResponseMessage"],
    response: List<Response>.from(json["Response"].map((x) => Response.fromJson(x))),
    errors: List<dynamic>.from(json["errors"].map((x) => x)),
  );

}

class Response {
  Response({
    this.id,
    this.openingTime,
    this.closingTime,
    this.status,
    this.timeslots,
    this.day,
  });

  int? id;
  String? openingTime;
  String? closingTime;
  String? status;
  List<Timeslot>? timeslots;
  Day? day;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    status: json["status"],
    timeslots: List<Timeslot>.from(json["timeslots"].map((x) => Timeslot.fromJson(x))),
    day: Day.fromJson(json["day"]),
  );

}

class Day {
  Day({
    this.id,
    this.name,
    this.date,
  });

  int? id;
  String? name;
  String? date;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    id: json["id"],
    name: json["name"],
    date: json["date"],
  );

}

class Timeslot {
  Timeslot({
    this.id,
    this.openSlotAt,
    this.closeSlotAt,
    this.workingDayId,
  });

  int? id;
  String? openSlotAt;
  String? closeSlotAt;
  int? workingDayId;

  factory Timeslot.fromJson(Map<String, dynamic> json) => Timeslot(
    id: json["id"],
    openSlotAt: json["open_slot_at"],
    closeSlotAt: json["close_slot_at"],
    workingDayId: json["working_day_id"],
  );

}
