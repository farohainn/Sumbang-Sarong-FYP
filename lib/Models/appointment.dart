
class AppointModel {

  String appointmentBy;
  String donationRecordByBK;
  String donationRecordTimeBK;
  String clothCategory;
  String genderCategory;
  int quantityAppointment;
  String appointmentRecord;
  String dateAppointment;
  String timeAppointment;
  bool isSuccess;

  AppointModel(
      {
        this.appointmentBy,
        this.donationRecordByBK,
        this.donationRecordTimeBK,
        this.clothCategory,
        this.genderCategory,
        this.quantityAppointment,
        this.appointmentRecord,
        this.dateAppointment,
        this.timeAppointment,
        this.isSuccess,
      });

  AppointModel.fromJson(Map<String, dynamic> json) {
    appointmentBy = json['appointmentBy'];
    donationRecordByBK = json['donationRecordByBK'];
    donationRecordTimeBK = json['donationRecordTimeBK'];
    clothCategory = json['clothCategory'];
    genderCategory = json['genderCategory'];
    quantityAppointment = json['quantityAppointment'];
    appointmentRecord = json['appointmentRecord'];
    dateAppointment = json['dateAppointment'];
    timeAppointment = json['timeAppointment'];
    isSuccess = json['isSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentBy'] = this.appointmentBy;
    data['donationRecordByBK'] = this.donationRecordByBK;
    data['donationRecordTimeBK'] = this.donationRecordTimeBK;
    data['clothCategory'] = this.clothCategory;
    data['genderCategory'] = this.genderCategory;
    data['dateAppointment'] = this.dateAppointment;
    data['timeAppointment'] = this.timeAppointment;
    if (this.appointmentRecord != null) {
      data['appointmentRecord'] = this.appointmentRecord;
    }
    data['quantityAppointment'] = this.quantityAppointment;
    data['isSuccess'] = this.isSuccess;
    return data;
  }
}


