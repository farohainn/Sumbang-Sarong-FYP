import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {

  String recordBy;
  String nameRecordBy;
  String iconSelected;
  String genderCategoryByBK;
  String recordTime;
  String clothCategoryByBK;
  int quantityByBK;
  int quantityPending;

  ItemModel(
      {
        this.recordBy,
        this.nameRecordBy,
        this.iconSelected,
        this.genderCategoryByBK,
        this.recordTime,
        this.clothCategoryByBK,
        this.quantityByBK,
        this.quantityPending,
        });

  ItemModel.fromJson(Map<String, dynamic> json) {
    recordBy = json['recordBy'];
    nameRecordBy = json['nameRecordBy'];
    iconSelected = json['iconSelected'];
    genderCategoryByBK = json['genderCategoryByBK'];
    recordTime = json['recordTime'];
    clothCategoryByBK = json['clothCategoryByBK'];
    quantityByBK = json['quantityByBK'];
    quantityPending = json['quantityPending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recordBy'] = this.recordBy;
    data['nameRecordBy'] = this.nameRecordBy;
    data['iconSelected'] = this.iconSelected;
    data['genderCategoryByBK'] = this.genderCategoryByBK;
    data['quantityByBK'] = this.quantityByBK;
    if (this.recordTime != null) {
      data['recordTime'] = this.recordTime;
    }
    data['clothCategoryByBK'] = this.clothCategoryByBK;
    data['quantityPending'] = this.quantityPending;
    return data;
  }
}

// class PublishedDate {
//   String date;
//
//   PublishedDate({this.date});
//
//   PublishedDate.fromJson(Map<String, dynamic> json) {
//     date = json['$date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['$date'] = this.date;
//     return data;
//   }
// }

