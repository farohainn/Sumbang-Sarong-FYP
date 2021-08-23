class Penyumbang {

  String name;
  String uid;
  String phone;

  Penyumbang(
      {
        this.name,
        this.uid,
        this.phone,
      });

  Penyumbang.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    phone = json['phone'];
  }}
