class TransStatus {
  String? tRANREFNO;
  String? rESPONSE;
  String? bANKRRN;
  String? tRADT;

  TransStatus({this.tRANREFNO, this.rESPONSE, this.bANKRRN, this.tRADT});

  TransStatus.fromJson(Map<String, dynamic> json) {
    tRANREFNO = json['TRANREFNO'];
    rESPONSE = json['RESPONSE'];
    bANKRRN = json['BANKRRN'];
    tRADT = json['TRADT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TRANREFNO'] = this.tRANREFNO;
    data['RESPONSE'] = this.rESPONSE;
    data['BANKRRN'] = this.bANKRRN;
    data['TRADT'] = this.tRADT;
    return data;
  }
}
