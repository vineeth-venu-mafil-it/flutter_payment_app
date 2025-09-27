class TableModel {
  int? iD;
  String? nAME;

  TableModel({this.iD, this.nAME});

  TableModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    return data;
  }
}
