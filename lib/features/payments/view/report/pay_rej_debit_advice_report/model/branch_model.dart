class BranchModel {
  int? bRANCHID;
  String? bRANCH;

  BranchModel({this.bRANCHID, this.bRANCH});

  BranchModel.fromJson(Map<String, dynamic> json) {
    bRANCHID = json['BRANCH_ID'];
    bRANCH = json['BRANCH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BRANCH_ID'] = this.bRANCHID;
    data['BRANCH'] = this.bRANCH;
    return data;
  }
}
