class ApiEndPoints {
  // static const String baseURL =
  //     'https://localhost:44346/api/Report/';
  static const String baseURL =
      'https://uatapp.manappuram.net/';
  static const String baseUrlGet =
      '${baseURL}PaymentReportApi/api/Report/';
  static const String baseUrlPost =
      '${baseURL}PaymentReportApi/api/PostReport';
  static const String portalURL =
      '${baseURL}PortalSessionApi/api/PortalSession/PortalDecrypt';
  static const String validateToken =
      '${baseURL}DecryptionApi/api/dec/hextobase';
  static const String routePortal =
      '${baseURL}MaaPortal/login';
  static const String menuBaseUrl =
      '${baseURL}MenuApi/api/MenuApi/GetMenuData/';


  ///web service
  static const String webServiceUrl =
      'https://feebased.manappuram.net/PAYMENTIMPSAPI/ImpsInquiryServiceICICI.asmx?op=';

  /*---------------------------*/
  static const String formAccess = "FORM_ACCESS/";
  static const String paymentAccess = "PAYMENTSTATUS_ACCESS/";
  static const String paymentData = "PAYMENTSTATUS_DATA/";
  static const String paymentRadio = "PAYMENTSTATUS_RADIO_ACCESS/";
  static const String impsAccess = "IMPS_ACCESS/";
  static const String paymentReport = "PAYMENT_REPORT/";
  static const String getPaymentReport1 = "GETPAYMENTREPORT1*";
  static const String getPaymentReport2 = "GETPAYMENTREPORT2*";
  static const String getPaymentReport3 = "GETPAYMENTREPORT3*";
  static const String getPaymentReport4 = "GETPAYMENTREPORT4*";
  static const String getPaymentReport5 = "GETPAYMENTREPORT5*";
  static const String paymentStatusCustId = "PAYMENTSTATUS_CUSID/";
  static const String paymentStatusSeq1 = "PAYMENTSTATUSSEQ1/";
  static const String paymentStatusSeq2 = "PAYMENTSTATUSSEQ2/";
  static const String paymentStatusSeq3 = "PAYMENTSTATUSSEQ3/";
  static const String paymentStatusSeq4 = "PAYMENTSTATUSSEQ4/";
  static const String paymentStatusSeq5 = "PAYMENTSTATUSSEQ5/";
  static const String empDetails = "EMPDETAILS/";

}
