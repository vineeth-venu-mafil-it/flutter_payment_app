class Transaction {
  String? actCode;
  String? response;
  String? bankRRN;
  String? tranRefNo;
  String? paymentRef;
  String? tranDateTime;
  String? amount;
  String? beneMMID;
  String? beneMobile;
  String? beneAccNo;
  String? beneIFSC;
  String? beneName;
  String? remMobile;
  String? remName;
  String? retailerCode;

  Transaction(
      {this.actCode,
      this.response,
      this.bankRRN,
      this.tranRefNo,
      this.paymentRef,
      this.tranDateTime,
      this.amount,
      this.beneMMID,
      this.beneMobile,
      this.beneAccNo,
      this.beneIFSC,
      this.beneName,
      this.remMobile,
      this.remName,
      this.retailerCode});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      actCode: json['ActCode'] as String?,
      response: json['Response'] as String?,
      bankRRN: json['BankRRN'] as String?,
      tranRefNo: json['TranRefNo'] as String?,
      paymentRef: json['PaymentRef'] as String?,
      tranDateTime: json['TranDateTime'] as String?,
      amount: json['Amount'] as String?,
      beneMMID: json['BeneMMID'] as String?,
      beneMobile: json['BeneMobile'] as String?,
      beneAccNo: json['BeneAccNo'] as String?,
      beneIFSC: json['BeneIFSC'] as String?,
      beneName: json['BeneName'] as String?,
      remMobile: json['RemMobile'] as String?,
      remName: json['RemName'] as String?,
      retailerCode: json['RetailerCode'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ActCode': actCode,
      'Response': response,
      'BankRRN': bankRRN,
      'TranRefNo': tranRefNo,
      'PaymentRef': paymentRef,
      'TranDateTime': tranDateTime,
      'Amount': amount,
      'BeneMMID': beneMMID,
      'BeneMobile': beneMobile,
      'BeneAccNo': beneAccNo,
      'BeneIFSC': beneIFSC,
      'BeneName': beneName,
      'RemMobile': remMobile,
      'RemName': remName,
      'RetailerCode': retailerCode,
    };
  }
}
