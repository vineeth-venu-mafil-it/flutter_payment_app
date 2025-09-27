class TransactionModel {
  String? sEQNO;
  String? tRANSACTIONS;

  TransactionModel({this.sEQNO, this.tRANSACTIONS});

  TransactionModel.fromJson(Map<String, dynamic> json) {
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