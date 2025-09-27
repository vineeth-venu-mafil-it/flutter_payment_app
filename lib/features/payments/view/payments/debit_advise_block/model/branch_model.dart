class BranchModel {
  double? bRID;
  String? bRANCH;

  BranchModel({this.bRID, this.bRANCH});

  BranchModel.fromJson(Map<String, dynamic> json) {
    bRID = json['BRID'];
    bRANCH = json['BRANCH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BRID'] = this.bRID;
    data['BRANCH'] = this.bRANCH;
    return data;
  }
}
