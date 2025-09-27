class BankDropModel {
  int? id;
  String? selectImpsBank;

  BankDropModel({this.id, this.selectImpsBank});

  factory BankDropModel.fromJson(Map<String, dynamic> json) {
    return BankDropModel(
      id: json['-1'] ?? json["'-1'"],
      selectImpsBank: json["'---SELECTNEFTBANK---'"] ?? json["'---SELECTIMPSBANK---'"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '-1': id,
      '---SELECTIMPSBANK---': selectImpsBank,
    };
  }
}
