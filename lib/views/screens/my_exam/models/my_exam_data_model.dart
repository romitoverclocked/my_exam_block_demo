

import 'dart:convert';

MyExamData myExamDataFromJson(String str) => MyExamData.fromJson(json.decode(str));

String myExamDataToJson(MyExamData data) => json.encode(data.toJson());

class MyExamData {
  bool? status;
  String? message;
  Data? data;

  MyExamData({
    this.status,
    this.message,
    this.data,
  });

  factory MyExamData.fromJson(Map<String, dynamic> json) => MyExamData(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  dynamic userExamName;
  int? scanTypeId;
  int? userId;
  String? examName;
  dynamic examZipName;
  int? status;
  DateTime? createdAt;
  dynamic deletedAt;
  UserNicename? userNicename;
  ReviewStatus? reviewStatus;
  String? clipFileVideo;
  FullName? fullName;
  int? counts;
  List<Group>? groups;

  Datum({
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

  factory Datum.fromJson(Map json) => Datum(
    id: json["id"],
    userExamName: json["user_exam_name"],
    scanTypeId: json["scan_type_id"],
    userId: json["user_id"],
    examName: json["exam_name"],
    examZipName: json["exam_zip_name"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    deletedAt: json["deleted_at"],
    userNicename: userNicenameValues.map[json["user_nicename"]]!,
    reviewStatus: reviewStatusValues.map[json["review_status"]]!,
    clipFileVideo: json["clip_file_video"],
    fullName: fullNameValues.map[json["full_name"]]!,
    counts: json["counts"],
    groups: json["groups"] == null ? [] : List<Group>.from(json["groups"]!.map((x) => groupValues.map[x]!)),
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
    "user_nicename": userNicenameValues.reverse[userNicename],
    "review_status": reviewStatusValues.reverse[reviewStatus],
    "clip_file_video": clipFileVideo,
    "full_name": fullNameValues.reverse[fullName],
    "counts": counts,
    "groups": groups == null ? [] : List<dynamic>.from(groups!.map((x) => groupValues.reverse[x])),
  };
}

enum FullName {
  A_JAIMIS_B_PATEL
}

final fullNameValues = EnumValues({
  "AJaimis BPatel": FullName.A_JAIMIS_B_PATEL
});

enum Group {
  ADMIN,
  CENTRA_CARE_ST_CLOUD_FMRP,
  CENTRA_CARE_ST_CLOUD_FMRP_202223,
  CHEHALIS_FAMILY_MEDICINE_CFM,
  CONTRA_COSTA_CCRMC_GROUPS,
  CONTRA_COSTA_FAMILY_MEDICINE_RESIDENTS,
  CONTRA_COSTA_POCUS_COURSE_JANUARY_2020,
  CONTRA_COSTA_POCUS_COURSE_JANUARY_2023,
  TEST_NAME
}

final groupValues = EnumValues({
  "Admin": Group.ADMIN,
  "CentraCare St. Cloud FMRP": Group.CENTRA_CARE_ST_CLOUD_FMRP,
  "CentraCare St. Cloud FMRP 2022-23": Group.CENTRA_CARE_ST_CLOUD_FMRP_202223,
  "Chehalis Family Medicine (CFM)": Group.CHEHALIS_FAMILY_MEDICINE_CFM,
  "Contra Costa CCRMC Groups": Group.CONTRA_COSTA_CCRMC_GROUPS,
  "Contra Costa Family Medicine Residents": Group.CONTRA_COSTA_FAMILY_MEDICINE_RESIDENTS,
  "Contra Costa POCUS Course January 2020": Group.CONTRA_COSTA_POCUS_COURSE_JANUARY_2020,
  "Contra Costa POCUS Course January 2023": Group.CONTRA_COSTA_POCUS_COURSE_JANUARY_2023,
  "Test name": Group.TEST_NAME
});

enum ReviewStatus {
  DRAFT,
  REVIEWED,
  SUBMITTED
}

final reviewStatusValues = EnumValues({
  "Draft": ReviewStatus.DRAFT,
  "Reviewed": ReviewStatus.REVIEWED,
  "Submitted": ReviewStatus.SUBMITTED
});

enum UserNicename {
  JEMISH15
}

final userNicenameValues = EnumValues({
  "jemish15": UserNicename.JEMISH15
});

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
