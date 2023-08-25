
import 'dart:convert';

import 'my_exam_data_model.dart';

SharedWithMeExam sharedWithMeExamFromJson(String str) => SharedWithMeExam.fromJson(json.decode(str));

String sharedWithMeExamToJson(SharedWithMeExam data) => json.encode(data.toJson());

class SharedWithMeExam {
  bool? status;
  String? message;
  List<Datum>? data;

  SharedWithMeExam({
    this.status,
    this.message,
    this.data,
  });

  factory SharedWithMeExam.fromJson(Map<String, dynamic> json) => SharedWithMeExam(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
