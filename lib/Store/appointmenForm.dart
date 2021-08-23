import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/Store/home_page.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';


class AppointmentForm extends StatefulWidget {

  final int quantityDonate;
  final String recordName;
  final String clothCategory;
  final String genderCategory;
  final String recordby;
  final String recordTime;
  final String donateRecord;
  final int quantityPending;

  AppointmentForm({Key key, this.quantityDonate, this.donateRecord, this.quantityPending, this.recordName, this.clothCategory, this.genderCategory, this.recordby, this.recordTime, }) : super(key: key);

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {

  String _date = "Tarikh Belum Tetap";
  String _time = "Masa Belum Tetap";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3 + 20,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset(
                      'images/appointment.jpg',
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.pinkAccent[700].withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 50,
                left: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 30,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 130,
                        ),
                        Text(
                          'Tetapan Tarikh dan Masa Janji Temu',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 4.0,
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime(2021, 1, 1),
                                maxTime: DateTime(2025, 12, 31),
                                onConfirm: (date) {
                                  print('Sah $date');
                                  _date =
                                  '${date.year} - ${date.month} - ${date
                                      .day}';
                                  setState(() {});
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            size: 18.0,
                                            color: Colors.pink,
                                          ),
                                          Text(
                                            " $_date",
                                            style: TextStyle(
                                                color: Colors.pink,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "  Tukar",
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 4.0,
                          onPressed: () {
                            DatePicker.showTimePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 210.0,
                                ),
                                showTitleActions: true,
                                onConfirm: (time) {
                                  print('Sah $time');
                                  _time =
                                  '${time.hour} : ${time.minute}';
                                  setState(() {});
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 18.0,
                                            color: Colors.pink,
                                          ),
                                          Text(
                                            " $_time",
                                            style: TextStyle(
                                                color: Colors.pink,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "  Tukar",
                                  style: TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3-5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 80.0, top: 350),
                  child: Center(
                    child: InkWell(
                        onTap: () {
                          print("dah 1");
                          saveAppointmentInfo();
                        },
                        child: Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.pink
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.airport_shuttle, color: Colors.white,),
                                  SizedBox(width: 1 * (MediaQuery.of(context).size.width/100),),
                                  Text("Tempah Janji Temu", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 2.5 * (MediaQuery.of(context).size.height/100),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans-Bold'
                                  ),)
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3 - 100,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        height: MediaQuery.of(context).size.height / 6 + 20,
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent[700],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          //fit: StackFit.expand,
                          children: <Widget>[
                            widget.clothCategory == "Baju Melayu"
                                ? Positioned(
                              top: 26,
                              right: 25,
                              child: Image.asset(
                                "images/baju1.png",
                                scale: 4.0,
                              ),
                            )
                                : widget.clothCategory == "Seluar."
                                ? Positioned(
                              top: 10,
                              right: 5,
                              child: Image.asset(
                                "images/baju2.png",
                                scale: 5.0,
                              ),
                            )
                                : widget.clothCategory == "Baju Lengan Pendek"
                                ? Positioned(
                              top: 26,
                              right: 5,
                              child: Image.asset(
                                "images/baju3.png",
                                scale: 7.0,
                              ),
                            )
                                : widget.clothCategory == "Baju Kurung"
                                ? Positioned(
                              top: 10,
                              right: 5,
                              child: Image.asset(
                                "images/baju4.png",
                                scale: 5.0,
                              ),
                            )
                                : widget.clothCategory == "Seluar"
                                ? Positioned(
                              top: 26,
                              right: 25.0,
                              child: Image.asset(
                                "images/baju5.png",
                                scale: 3,
                              ),
                            )
                                : widget.clothCategory ==
                                "Baju Lengan Panjang"
                                ? Positioned(
                              top: 10,
                              right: 5,
                              child: Image.asset(
                                "images/baju6.png",
                                scale: 5.0,
                              ),
                            )
                                : circularProgress(),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            widget.recordName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.clothCategory + ", " + widget.genderCategory,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              widget.quantityDonate.toString() + " helai",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.pink,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveAppointmentInfo() {

    if(_date == "Tarikh Belum Tetap" || _time == "Masa Belum Tetap"){
      displayDialog("Sila tetapkan tarikh dan masa untuk janji temu.");
    }
    else if(_date == "Tarikh Belum Tetap" && _time == "Masa Belum Tetap"){
      displayDialog("Sila tetapkan tarikh dan masa untuk janji temu.");
    }
    else{
      uploadAppointment(_date, _time);
    }

  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(message: msg,);
        }
    );
  }


  uploadAppointment(String _date,String _time) async {
    writeAppointDetailsForPenyumbang({
      "appointmentBy": Sumbang.sharedPreferences.getString(Sumbang.userUID),
      Sumbang.donationRecordByBK: widget.recordby,
      Sumbang.donationRecordTimeBK: widget.recordTime,
      Sumbang.clothCategory : widget.clothCategory,
      Sumbang.genderCategory: widget.genderCategory,
      Sumbang.quantityAppointment: widget.quantityDonate,
      Sumbang.dateAppointment: _date,
      Sumbang.timeAppointment: _time,
      Sumbang.appointmentRecord: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      Sumbang.isSuccess: true,

    });

    writeAppointDetailsForBadanKebajikan({
      "appointmentBy": Sumbang.sharedPreferences.getString(Sumbang.userUID),
      Sumbang.donationRecordByBK: widget.recordby,
      Sumbang.donationRecordTimeBK: widget.recordTime,
      Sumbang.clothCategory : widget.clothCategory,
      Sumbang.genderCategory: widget.genderCategory,
      Sumbang.quantityAppointment: widget.quantityDonate,
      Sumbang.dateAppointment: _date,
      Sumbang.timeAppointment: _time,
      Sumbang.appointmentRecord: DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),
      Sumbang.isSuccess: true,
    }).whenComplete(() =>{


      completeDonate()

    });

  }

  completeDonate(){

    int pendingQuantity=0;
    int pendinQuantity=0;
    int totalQuantity=0;
    Firestore.instance.collection(Sumbang.collectionUserBK)
        .document(widget.recordby)
        .collection(Sumbang.collectionRecordBK)
        .where("recordTime", isEqualTo: widget.recordTime)
        .getDocuments()
        .then((docs) {
      pendingQuantity = docs.documents[0].data['quantityPending'];

      Firestore.instance.collection(Sumbang.collectionUserBK)
          .document(widget.recordby)
          .collection(Sumbang.collectionRecordBK)
          .document(widget.recordby + widget.recordTime).updateData({
        "quantityPending":  widget.quantityDonate + pendingQuantity,
      });

    });

    print("asaaaaaaaaaaa"+Sumbang.sharedPreferences.getString(Sumbang.userUID));
    print("jahshaj"+widget.donateRecord);

    Firestore.instance.collection(Sumbang.infoDonate)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUID)+ widget.donateRecord)
        .delete();

    Firestore.instance.collection(Sumbang.infoDonate)
        .where("donationRecordTimeBK", isEqualTo: widget.recordTime)
        .where("donationRecordByBK", isEqualTo: widget.recordby)
        .getDocuments()
        .then((docs) {
      pendinQuantity = docs.documents[0].data['quantityPending'];
      totalQuantity = docs.documents[0].data['quantityPending'] + docs.documents[0].data['quantityBalance'];

      Firestore.instance.collection(Sumbang.infoDonate)
          .document(docs.documents[0].data['donateBy'] + docs.documents[0].data['donateRecord']).updateData({
        "quantityPending":  widget.quantityDonate + pendinQuantity,
        "quantityBalance":  totalQuantity - (widget.quantityDonate + pendinQuantity),
      });
    });


    Fluttertoast.showToast(msg: "Tahniah, janji temu sudah berjaya!");

    Route route = MaterialPageRoute(builder: (c) => HomePage());
    Navigator.pushReplacement(context, route);
  }


  Future writeAppointDetailsForPenyumbang(Map<String, dynamic> data) async{
    await Sumbang.firestore
        .collection(Sumbang.collectionAppointmentSum)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUID) + data['appointmentRecord'])
        .setData(data);

    await Sumbang.firestore.collection(Sumbang.collectionUser)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUID))
        .collection(Sumbang.collectionAppointment)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUID) + data['appointmentRecord'])
        .setData(data);
  }

  Future writeAppointDetailsForBadanKebajikan(Map<String, dynamic> data) async{
    await Sumbang.firestore.collection(Sumbang.collectionUserBK)
        .document(widget.recordby)
        .collection(Sumbang.collectionRecordBK)
        .document(widget.recordby + widget.recordTime)
        .collection(Sumbang.collectionAppointmentBK)
        .document((Sumbang.sharedPreferences.getString(Sumbang.userUID) + data['appointmentRecord']))
        .setData(data);

    await Sumbang.firestore
        .collection(Sumbang.collectionAppointmentBKSum)
        .document((Sumbang.sharedPreferences.getString(Sumbang.userUID) + data['appointmentRecord']))
        .setData(data);
  }
}

