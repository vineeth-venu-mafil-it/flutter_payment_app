class TransModel {
  String? sEQNO;
  String? tRANSACTIONS;

  TransModel({this.sEQNO, this.tRANSACTIONS});

  TransModel.fromJson(Map<String, dynamic> json) {
    sEQNO = json['SEQ_NO'];
    tRANSACTIONS = json['TRANSACTIONS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SEQ_NO'] = this.sEQNO;
    data['TRANSACTIONS'] = this.tRANSACTIONS;
    return data;
  }
}
