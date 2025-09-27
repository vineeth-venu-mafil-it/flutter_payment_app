class MainMenuModel {
  String? mENUNAME;
  String? mENUID;
  String? lINK;
  String? iMAGEURL;

  MainMenuModel({this.mENUNAME, this.mENUID, this.lINK, this.iMAGEURL});

  MainMenuModel.fromJson(Map<String, dynamic> json) {
    mENUNAME = json['MENU_NAME'];
    mENUID = json['MENU_ID'];
    lINK = json['LINK'];
    iMAGEURL = json['IMAGEURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MENU_NAME'] = this.mENUNAME;
    data['MENU_ID'] = this.mENUID;
    data['LINK'] = this.lINK;
    data['IMAGEURL'] = this.iMAGEURL;
    return data;
  }
}
