class EmpDetailModel {
  List<Response>? response;

  EmpDetailModel({this.response});

  EmpDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  int? eMPCODE;
  String? eMPNAME;
  int? bRANCHID;
  String? bRANCHNAME;
  int? dESIGNATIONID;
  int? dEPARTMENTID;
  int? pOSTID;

  Response(
      {this.eMPCODE,
      this.eMPNAME,
      this.bRANCHID,
      this.bRANCHNAME,
      this.dESIGNATIONID,
      this.dEPARTMENTID,
      this.pOSTID});

  Response.fromJson(Map<String, dynamic> json) {
    eMPCODE = json['EMP_CODE'];
    eMPNAME = json['EMP_NAME'];
    bRANCHID = json['BRANCH_ID'];
    bRANCHNAME = json['BRANCH_NAME'];
    dESIGNATIONID = json['DESIGNATION_ID'];
    dEPARTMENTID = json['DEPARTMENT_ID'];
    pOSTID = json['POST_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EMP_CODE'] = this.eMPCODE;
    data['EMP_NAME'] = this.eMPNAME;
    data['BRANCH_ID'] = this.bRANCHID;
    data['BRANCH_NAME'] = this.bRANCHNAME;
    data['DESIGNATION_ID'] = this.dESIGNATIONID;
    data['DEPARTMENT_ID'] = this.dEPARTMENTID;
    data['POST_ID'] = this.pOSTID;
    return data;
  }
}
