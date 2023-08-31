// To parse this JSON data, do
//
//     final examClipModel = examClipModelFromJson(jsonString);

import 'dart:convert';

List<ExamClipModel> examClipModelFromJson(String str) => List<ExamClipModel>.from(json.decode(str).map((x) => ExamClipModel.fromJson(x)));

String examClipModelToJson(List<ExamClipModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExamClipModel {
  int? id;
  dynamic portfolioId;
  dynamic caseCategoryId;
  dynamic examId;
  int? userId;
  String? clipFileVideo;
  int? status;
  DateTime? date;

  ExamClipModel({
    this.id,
    this.portfolioId,
    this.caseCategoryId,
    this.examId,
    this.userId,
    this.clipFileVideo,
    this.status,
    this.date,
  });

  factory ExamClipModel.fromJson(Map json) => ExamClipModel(
    id: json["id"],
    portfolioId: json["portfolio_id"],
    caseCategoryId: json["case_category_id"],
    examId: json["exam_id"],
    userId: json["user_id"],
    clipFileVideo: json["clip_file_video"],
    status: json["status"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "portfolio_id": portfolioId,
    "case_category_id": caseCategoryId,
    "exam_id": examId,
    "user_id": userId,
    "clip_file_video": clipFileVideo,
    "status": status,
    "date": date?.toIso8601String(),
  };
}
