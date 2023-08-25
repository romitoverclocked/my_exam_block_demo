
import 'dart:convert';

ScansModel scansModelFromJson(String str) => ScansModel.fromJson(json.decode(str));

String scansModelToJson(ScansModel data) => json.encode(data.toJson());

class ScansModel {
  bool? status;
  String? message;
  List<Datum>? data;

  ScansModel({
    this.status,
    this.message,
    this.data,
  });

  factory ScansModel.fromJson(Map<String, dynamic> json) => ScansModel(
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

class Datum {
  int? id;
  String? categoryName;
  String? categoryImage;

  Datum({
    this.id,
    this.categoryName,
    this.categoryImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    categoryName: json["category_name"],
    categoryImage: json["category_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_image": categoryImage,
  };
}
