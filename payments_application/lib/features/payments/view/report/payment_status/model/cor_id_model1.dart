class CorIDdataModel1 {
  List<CorIdResponse1>? response;

  CorIDdataModel1({this.response});

  CorIDdataModel1.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <CorIdResponse1>[];
      json['response'].forEach((v) {
        response!.add(new CorIdResponse1.fromJson(v));
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

class CorIdResponse1 {
  String? cORPORATEID;
  String? tRADT;
  String? bANK;

  CorIdResponse1({this.cORPORATEID, this.tRADT, this.bANK});

  CorIdResponse1.fromJson(Map<String, dynamic> json) {
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
