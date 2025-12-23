class DebitAdviceReportModel {
  int? sLNO;
  String? rEGNAME;
  String? aREANAME;
  String? bRANCHNAME;
  int? bRANCHID;
  String? pLEDGENO;
  String? cUSTID;
  String? cUSTNAME;
  int? aMOUNT;
  String? tRADATE;
  String? rESPONSE;

  DebitAdviceReportModel(
      {this.sLNO,
        this.rEGNAME,
        this.aREANAME,
        this.bRANCHNAME,
        this.bRANCHID,
        this.pLEDGENO,
        this.cUSTID,
        this.cUSTNAME,
        this.aMOUNT,
        this.tRADATE,
        this.rESPONSE});

  DebitAdviceReportModel.fromJson(Map<String, dynamic> json) {
    sLNO = json['SLNO'];
    rEGNAME = json['REG_NAME'];
    aREANAME = json['AREA_NAME'];
    bRANCHNAME = json['BRANCH_NAME'];
    bRANCHID = json['BRANCH_ID'];
    pLEDGENO = json['PLEDGE_NO'];
    cUSTID = json['CUST_ID'];
    cUSTNAME = json['CUST_NAME'];
    aMOUNT = json['AMOUNT'];
    tRADATE = json['TRA_DATE'];
    rESPONSE = json['RESPONSE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SLNO'] = this.sLNO;
    data['REG_NAME'] = this.rEGNAME;
    data['AREA_NAME'] = this.aREANAME;
    data['BRANCH_NAME'] = this.bRANCHNAME;
    data['BRANCH_ID'] = this.bRANCHID;
    data['PLEDGE_NO'] = this.pLEDGENO;
    data['CUST_ID'] = this.cUSTID;
    data['CUST_NAME'] = this.cUSTNAME;
    data['AMOUNT'] = this.aMOUNT;
    data['TRA_DATE'] = this.tRADATE;
    data['RESPONSE'] = this.rESPONSE;
    return data;
  }
}
