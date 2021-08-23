import 'package:cloud_firestore/cloud_firestore.dart';

class AdminInfoModel {

  String nameBK;
  String emailBK;
  String passwdBK;
  String phoneBK;
  String addressBK;
  String uidBK;
  String urlBK;
  Timestamp publishedDate;


  AdminInfoModel(
      {
        this.nameBK,
        this.emailBK,
        this.passwdBK,
        this.phoneBK,
        this.addressBK,
        this.uidBK,
        this.urlBK,
        this.publishedDate,
      });

  AdminInfoModel.fromJson(Map<String, dynamic> json) {

    nameBK = json['nameBK'];
    emailBK = json['emailBK'];
    passwdBK = json['passwdBK'];
    phoneBK = json['phoneBK'];
    addressBK = json['addressBK'];
    uidBK = json['uidBK'];
    urlBK = json['urlBK'];
    publishedDate = json['publishedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['nameBK'] = this.nameBK;
    data['emailBK'] = this.emailBK;
    data['passwdBK'] = this.passwdBK;
    data['phoneBK'] = this.phoneBK;
    data['addressBK'] = this.addressBK;
    data['uidBK'] = this.uidBK;
    data['urlBK'] = this.urlBK;
    if (this.publishedDate != null) {
      data['publishedDate'] = this.publishedDate;
    }
    return data;
  }
}

class PublishedDate {
  String date;

  PublishedDate({this.date});

  PublishedDate.fromJson(Map<String, dynamic> json) {
    date = json['$date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$date'] = this.date;
    return data;
  }
}

