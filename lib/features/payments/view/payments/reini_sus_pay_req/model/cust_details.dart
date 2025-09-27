class CustDetails {
  String? cUSTNAME;
  String? bANKNAME;
  String? iFSCCODE;
  String? bENEFICIARYBRANCH;
  String? bENEFICIARYACCOUNT;

  CustDetails(
      {this.cUSTNAME,
        this.bANKNAME,
        this.iFSCCODE,
        this.bENEFICIARYBRANCH,
        this.bENEFICIARYACCOUNT});

  CustDetails.fromJson(Map<String, dynamic> json) {
    cUSTNAME = json['CUST_NAME'];
    bANKNAME = json['BANKNAME'];
    iFSCCODE = json['IFSC_CODE'];
    bENEFICIARYBRANCH = json['BENEFICIARY_BRANCH'];
    bENEFICIARYACCOUNT = json['BENEFICIARY_ACCOUNT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CUST_NAME'] = this.cUSTNAME;
    data['BANKNAME'] = this.bANKNAME;
    data['IFSC_CODE'] = this.iFSCCODE;
    data['BENEFICIARY_BRANCH'] = this.bENEFICIARYBRANCH;
    data['BENEFICIARY_ACCOUNT'] = this.bENEFICIARYACCOUNT;
    return data;
  }
}