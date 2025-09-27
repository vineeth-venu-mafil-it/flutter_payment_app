class OglRptSbiTransDet {
  String? cUSTOMERREFNO;
  String? iNSTRUMENTVALUEDATE;
  int? aMOUNT;
  String? bENENAME;
  String? iFSCCODE;
  String? bENEACCNUMBER;
  String? lOANNO;
  String? pAYDATE;
  String? pAYSTATUS;
  String? bANKREFNO;
  int? tRANSID;
  String? dESCRIPTION;
  String? bATCHNO;

  OglRptSbiTransDet(
      {this.cUSTOMERREFNO,
        this.iNSTRUMENTVALUEDATE,
        this.aMOUNT,
        this.bENENAME,
        this.iFSCCODE,
        this.bENEACCNUMBER,
        this.lOANNO,
        this.pAYDATE,
        this.pAYSTATUS,
        this.bANKREFNO,
        this.tRANSID,
        this.dESCRIPTION,
        this.bATCHNO});

  OglRptSbiTransDet.fromJson(Map<String, dynamic> json) {
    cUSTOMERREFNO = json['CUSTOMER_REF_NO'];
    iNSTRUMENTVALUEDATE = json['INSTRUMENT_VALUE_DATE'];
    aMOUNT = json['AMOUNT'];
    bENENAME = json['BENE_NAME'];
    iFSCCODE = json['IFSC_CODE'];
    bENEACCNUMBER = json['BENE_ACC_NUMBER'];
    lOANNO = json['LOAN_NO'];
    pAYDATE = json['PAY_DATE'];
    pAYSTATUS = json['PAY_STATUS'];
    bANKREFNO = json['BANK_REF_NO'];
    tRANSID = json['TRANSID'];
    dESCRIPTION = json['DESCRIPTION'];
    bATCHNO = json['BATCH_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CUSTOMER_REF_NO'] = this.cUSTOMERREFNO;
    data['INSTRUMENT_VALUE_DATE'] = this.iNSTRUMENTVALUEDATE;
    data['AMOUNT'] = this.aMOUNT;
    data['BENE_NAME'] = this.bENENAME;
    data['IFSC_CODE'] = this.iFSCCODE;
    data['BENE_ACC_NUMBER'] = this.bENEACCNUMBER;
    data['LOAN_NO'] = this.lOANNO;
    data['PAY_DATE'] = this.pAYDATE;
    data['PAY_STATUS'] = this.pAYSTATUS;
    data['BANK_REF_NO'] = this.bANKREFNO;
    data['TRANSID'] = this.tRANSID;
    data['DESCRIPTION'] = this.dESCRIPTION;
    data['BATCH_NO'] = this.bATCHNO;
    return data;
  }
}
