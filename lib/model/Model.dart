// To parse this JSON data, do
//
//     final myModel = myModelFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

class MyModel {
  MyModel({
    this.selection2,
  });

  List<Selection2> selection2;

  factory MyModel.fromJson(String str) => MyModel.fromMap(json.decode(str));

  factory MyModel.fromMap(Map<String, dynamic> json) => MyModel(
        selection2: json["selection2"] == null
            ? null
            : List<Selection2>.from(json["selection2"].map((x) => Selection2.fromMap(x))),
      );
}

class Selection2 {
  Selection2({
    this.date,
    this.timeSlots,
  });

  DateTime date;
  List<TimeSlot> timeSlots;

  factory Selection2.fromJson(String str) => Selection2.fromMap(json.decode(str));

  factory Selection2.fromMap(Map<String, dynamic> json) => Selection2(
        date: json["Date"] == null ? null : createDateTime(json["Date"]),
        timeSlots:
            json["TimeSlots"] == null ? null : List<TimeSlot>.from(json["TimeSlots"].map((x) => TimeSlot.fromMap(x))),
      );
}

class TimeSlot {
  TimeSlot({
    this.time,
    this.available,
  });

  String time;
  String available;

  factory TimeSlot.fromJson(String str) => TimeSlot.fromMap(json.decode(str));

  factory TimeSlot.fromMap(Map<String, dynamic> json) => TimeSlot(
        time: json["time"] == null ? null : json["time"],
        available: json["available"] == null ? null : json["available"],
      );
}

createDateTime(String date) {
  // return DateTime.now();
  DateTime dateTime =
      new DateFormat("dd/MMM/yyyy").parse("${date.split('-')[0]}/${date.split('-')[1]}/${date.split('-')[2]}");
  return dateTime;
}
