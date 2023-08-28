// To parse this JSON data, do
//
//     final examData = examDataFromJson(jsonString);

import 'dart:convert';

List<ExamData> examDataFromJson(String str) =>
    List<ExamData>.from(json.decode(str).map((x) => ExamData.fromJson(x)));

String examDataToJson(List<ExamData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExamData {
  int? id;
  dynamic userExamName;
  int? scanTypeId;
  int? userId;
  String? examName;
  dynamic examZipName;
  int? status;
  DateTime? createdAt;
  dynamic deletedAt;
  String? userNicename;
  String? reviewStatus;
  String? clipFileVideo;
  String? fullName;
  int? counts;
  List<String>? groups;

  ExamData({
    this.id,
    this.userExamName,
    this.scanTypeId,
    this.userId,
    this.examName,
    this.examZipName,
    this.status,
    this.createdAt,
    this.deletedAt,
    this.userNicename,
    this.reviewStatus,
    this.clipFileVideo,
    this.fullName,
    this.counts,
    this.groups,
  });

  factory ExamData.fromJson(Map json) => ExamData(
        id: json["id"],
        userExamName: json["user_exam_name"],
        scanTypeId: json["scan_type_id"],
        userId: json["user_id"],
        examName: json["exam_name"],
        examZipName: json["exam_zip_name"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
        userNicename: json["user_nicename"],
        reviewStatus: json["review_status"],
        clipFileVideo: json["clip_file_video"],
        fullName: json["full_name"],
        counts: json["counts"],
        groups: json["groups"] == null
            ? []
            : List<String>.from(json["groups"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_exam_name": userExamName,
        "scan_type_id": scanTypeId,
        "user_id": userId,
        "exam_name": examName,
        "exam_zip_name": examZipName,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "user_nicename": userNicename,
        "review_status": reviewStatus,
        "clip_file_video": clipFileVideo,
        "full_name": fullName,
        "counts": counts,
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
      };
}
