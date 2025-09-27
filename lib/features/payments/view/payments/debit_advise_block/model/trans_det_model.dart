class TransDetailsModel {
  String? tRANSDETAILS;

  TransDetailsModel({this.tRANSDETAILS});

  TransDetailsModel.fromJson(Map<String, dynamic> json) {
    tRANSDETAILS = json['TRANS_DETAILS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TRANS_DETAILS'] = this.tRANSDETAILS;
    return data;
  }
}
