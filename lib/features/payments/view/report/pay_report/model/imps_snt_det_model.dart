class PayReImpSendDet {
  String? cORPORATEID;
  String? tRADT;
  String? bANK;

  PayReImpSendDet({this.cORPORATEID, this.tRADT, this.bANK});

  PayReImpSendDet.fromJson(Map<String, dynamic> json) {
    cORPORATEID = json['CORPORATE_ID'];
    tRADT = json['TRA_DT'];
    bANK = json['BANK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CORPORATE_ID'] = this.cORPORATEID;
    data['TRA_DT'] = this.tRADT;
    data['BANK'] = this.bANK;
    return data;
  }
}
