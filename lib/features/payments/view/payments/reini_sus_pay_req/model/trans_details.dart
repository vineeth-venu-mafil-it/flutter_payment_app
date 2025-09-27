class TransDetails {
  String? dOCID;
  double? aMOUNT;
  String? vALUEDATE;
  String? cORPORATEID;
  String? cUSTNAME;
  double? sETTLTRANSID;

  TransDetails(
      {this.dOCID,
        this.aMOUNT,
        this.vALUEDATE,
        this.cORPORATEID,
        this.cUSTNAME,
        this.sETTLTRANSID});

  TransDetails.fromJson(Map<String, dynamic> json) {
    dOCID = json['DOCID'];
    aMOUNT = json['AMOUNT'];
    vALUEDATE = json['VALUE_DATE'];
    cORPORATEID = json['CORPORATE_ID'];
    cUSTNAME = json['CUST_NAME'];
    sETTLTRANSID = json['SETTL_TRANSID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DOCID'] = this.dOCID;
    data['AMOUNT'] = this.aMOUNT;
    data['VALUE_DATE'] = this.vALUEDATE;
    data['CORPORATE_ID'] = this.cORPORATEID;
    data['CUST_NAME'] = this.cUSTNAME;
    data['SETTL_TRANSID'] = this.sETTLTRANSID;
    return data;
  }
}