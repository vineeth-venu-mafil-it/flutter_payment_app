class BankModel {
  int? bANKCODE;
  String? bANKNAME;

  BankModel({this.bANKCODE, this.bANKNAME});

  BankModel.fromJson(Map<String, dynamic> json) {
    bANKCODE = json['BANK_CODE'];
    bANKNAME = json['BANK_NAME'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BANK_CODE'] = this.bANKCODE;
    data['BANK_NAME'] = this.bANKNAME;
    return data;
  }
}
