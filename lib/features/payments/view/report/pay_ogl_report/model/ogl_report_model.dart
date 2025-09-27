class OGLReportModel {
  String? pAYMODE;
  String? pAYBANK;
  String? mODULE;
  String? bRANCHNAME;
  int? bRANCHID;
  String? dOCID;
  String? cUSTID;
  String? cUSTNAME;
  int? aMOUNT;
  String? tRADATE;
  String? cORPORATEID;
  String? pAYDATE;
  String? rESPONSE;
  String? bANKRRN;
  String? iFSCCODE;
  String? bENEFICIARYACCOUNT;
  int? sENDTRANSID;
  String? sEQNO;
  String? bATCHNO;

  OGLReportModel(
      {this.pAYMODE,
        this.pAYBANK,
        this.mODULE,
        this.bRANCHNAME,
        this.bRANCHID,
        this.dOCID,
        this.cUSTID,
        this.cUSTNAME,
        this.aMOUNT,
        this.tRADATE,
        this.cORPORATEID,
        this.pAYDATE,
        this.rESPONSE,
        this.bANKRRN,
        this.iFSCCODE,
        this.bENEFICIARYACCOUNT,
        this.sENDTRANSID,
        this.sEQNO,
        this.bATCHNO});

  OGLReportModel.fromJson(Map<String, dynamic> json) {
    pAYMODE = json['PAY_MODE'];
    pAYBANK = json['PAY_BANK'];
    mODULE = json['MODULE'];
    bRANCHNAME = json['BRANCH_NAME'];
    bRANCHID = json['BRANCH_ID'];
    dOCID = json['DOC_ID'];
    cUSTID = json['CUST_ID'];
    cUSTNAME = json['CUST_NAME'];
    aMOUNT = json['AMOUNT'];
    tRADATE = json['TRA_DATE'];
    cORPORATEID = json['CORPORATE_ID'];
    pAYDATE = json['PAY_DATE'];
    rESPONSE = json['RESPONSE'];
    bANKRRN = json['BANKRRN'];
    iFSCCODE = json['IFSC_CODE'];
    bENEFICIARYACCOUNT = json['BENEFICIARY_ACCOUNT'];
    sENDTRANSID = json['SEND_TRANSID'];
    sEQNO = json['SEQ_NO'];
    bATCHNO = json['BATCH_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PAY_MODE'] = this.pAYMODE;
    data['PAY_BANK'] = this.pAYBANK;
    data['MODULE'] = this.mODULE;
    data['BRANCH_NAME'] = this.bRANCHNAME;
    data['BRANCH_ID'] = this.bRANCHID;
    data['DOC_ID'] = this.dOCID;
    data['CUST_ID'] = this.cUSTID;
    data['CUST_NAME'] = this.cUSTNAME;
    data['AMOUNT'] = this.aMOUNT;
    data['TRA_DATE'] = this.tRADATE;
    data['CORPORATE_ID'] = this.cORPORATEID;
    data['PAY_DATE'] = this.pAYDATE;
    data['RESPONSE'] = this.rESPONSE;
    data['BANKRRN'] = this.bANKRRN;
    data['IFSC_CODE'] = this.iFSCCODE;
    data['BENEFICIARY_ACCOUNT'] = this.bENEFICIARYACCOUNT;
    data['SEND_TRANSID'] = this.sENDTRANSID;
    data['SEQ_NO'] = this.sEQNO;
    data['BATCH_NO'] = this.bATCHNO;
    return data;
  }
}
