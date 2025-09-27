class ModuleModel {
  double? moduleId;
  String? module;

  ModuleModel({this.moduleId, this.module});

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      moduleId: json['MODULE_ID'] != null ? json['MODULE_ID'].toDouble() : null,
      module: json['MODULE'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['MODULE_ID'] = this.moduleId;
    data['MODULE'] = this.module;
    return data;
  }
}