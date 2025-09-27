class BranchModel {
  double? BRID;
  String? BRANCH;

  BranchModel({this.BRID, this.BRANCH});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      BRID: json['BRID'] != null ? json['BRID'].toDouble() : null,
      BRANCH: json['BRANCH'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['BRID'] = this.BRID;
    data['BRANCH'] = this.BRANCH;
    return data;
  }
}