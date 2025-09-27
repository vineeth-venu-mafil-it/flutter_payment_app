class PaymentTabModel {
  String? sUBMENUNAME;
  String? mAINMENUID;
  String? lINK;
  String? sUBMENUID;

  PaymentTabModel(
      {this.sUBMENUNAME, this.mAINMENUID, this.lINK, this.sUBMENUID});

  PaymentTabModel.fromJson(Map<String, dynamic> json) {
    sUBMENUNAME = json['SUBMENU_NAME'];
    mAINMENUID = json['MAIN_MENU_ID'];
    lINK = json['LINK'];
    sUBMENUID = json['SUBMENU_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SUBMENU_NAME'] = this.sUBMENUNAME;
    data['MAIN_MENU_ID'] = this.mAINMENUID;
    data['LINK'] = this.lINK;
    data['SUBMENU_ID'] = this.sUBMENUID;
    return data;
  }
}
