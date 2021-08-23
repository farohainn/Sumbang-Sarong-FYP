class CharityModel {

  String nameNewBK;
  String uidNewBK;
  String emailNewBK;
  String phoneNewBK;
  String addressNewBK;

  CharityModel(
      {
        this.nameNewBK,
        this.uidNewBK,
        this.emailNewBK,
        this.phoneNewBK,
        this.addressNewBK,
      });

  CharityModel.fromJson(Map<String, dynamic> json) {
    nameNewBK = json['nameNewBK'];
    uidNewBK = json['uidNewBK'];
    emailNewBK = json['emailNewBK'];
    phoneNewBK = json['phoneNewBK'];
    addressNewBK = json['addressNewBK'];
  }
}