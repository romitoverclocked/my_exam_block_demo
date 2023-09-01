class ExamInterpretationsModel {
  ExamInterpretationsModel({
    this.id,
    this.scanTypeId,
    this.name,
    this.scanInputParamsId,
    this.isDefault,
    this.parentId,
    this.status,
    this.date,
    this.inputParams,
    this.children,
    this.scanValueList,
    this.selectedValue,
  });

  ExamInterpretationsModel.fromJson(Map json) {
    id = json['id'];
    scanTypeId = json['scan_type_id'];
    name = json['name'];
    scanInputParamsId = json['scan_input_params_id'];
    isDefault = json['is_default'];
    parentId = json['parent_id'];
    status = json['status'];
    date = json['date'];
    inputParams = json['input_params'] ?? "";
    selectedValue = json['selected_value'];
    scanValueList =
        json['input_params'] != null ? json['input_params'].split(",") : [];
    if (json['children'] != null) {
      children = [];
      json['children'].forEach((v) {
        children?.add(Children.fromJson(v));
      });
    }
  }

  num? id;
  num? scanTypeId;
  String? name;
  num? scanInputParamsId;
  String? isDefault;
  num? parentId;
  num? status;
  String? date;
  String? inputParams;
  String? selectedValue;
  List<Children>? children;
  List<String>? scanValueList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['scan_type_id'] = scanTypeId;
    map['name'] = name;
    map['scan_input_params_id'] = scanInputParamsId;
    map['is_default'] = isDefault;
    map['parent_id'] = parentId;
    map['selected_value'] = selectedValue;
    map['status'] = status;
    map['date'] = date;
    map['input_params'] = inputParams;
    if (children != null) {
      map['children'] = children?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Children {
  Children({
    this.id,
    this.scanTypeId,
    this.name,
    this.scanInputParamsId,
    this.isDefault,
    this.parentId,
    this.status,
    this.date,
    this.scanValueList,
    this.selectedValue,
  });

  Children.fromJson(Map json) {
    id = json['id'];
    scanTypeId = json['scan_type_id'];
    name = json['name'];
    scanInputParamsId = json['scan_input_params_id'];
    isDefault = json['is_default'];
    parentId = json['parent_id'];
    status = json['status'];
    date = json['date'];
    selectedValue = json['selected_value'];
    scanValueList =
        json['input_params'] != null ? json['input_params'].split(",") : [];
  }

  num? id;
  num? scanTypeId;
  String? name;
  num? scanInputParamsId;
  String? isDefault;
  num? parentId;
  num? status;
  String? date;
  List<String>? scanValueList;
  String? selectedValue;

  Map<String, dynamic> toJson() => {
        'id': id,
        'scan_type_id': scanTypeId,
        'name': name,
        'scan_input_params_id': scanInputParamsId,
        'is_default': isDefault,
        'parent_id': parentId,
        'status': status,
        'date': date,
        'input_params': scanValueList?.join(","),
        'selected_value': selectedValue
      };
}
