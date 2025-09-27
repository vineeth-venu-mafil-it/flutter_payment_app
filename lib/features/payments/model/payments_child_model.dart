class PaymentsChildModel {
  String? cHILDMENUNAME;
  String? sUBMENUID;
  String? cHILDMENUID;
  String? lINK;
  String? iMAGEURL;

  PaymentsChildModel(
      {this.cHILDMENUNAME,
      this.sUBMENUID,
      this.cHILDMENUID,
      this.lINK,
      this.iMAGEURL});

  PaymentsChildModel.fromJson(Map<String, dynamic> json) {
    cHILDMENUNAME = json['CHILDMENU_NAME'];
    sUBMENUID = json['SUB_MENU_ID'];
    cHILDMENUID = json['CHILDMENU_ID'];
    lINK = json['LINK'];
    iMAGEURL = json['IMAGEURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CHILDMENU_NAME'] = this.cHILDMENUNAME;
    data['SUB_MENU_ID'] = this.sUBMENUID;
    data['CHILDMENU_ID'] = this.cHILDMENUID;
    data['LINK'] = this.lINK;
    data['IMAGEURL'] = this.iMAGEURL;
    return data;
  }
}
