import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:sumbang_sarong/Store/product_page.dart';


class ProductDetails extends StatefulWidget {

  final Detail detail;
  ProductDetails({Key key, this.detail}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String _date = "Tarikh Belum Tetap";
  String _time = "Masa Belum Tetap";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.pink, Colors.cyanAccent],
                begin: const FractionalOffset(0.0, 0.0,),
                end: const FractionalOffset(1.0, 0.0),
                stops:[0.0,1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white,), onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CharityHubList())),
          ),
          title: Text("Janji Temu ke Rumah Kebajikan", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child:
                        widget.detail.iconSelected =="Baju Kurung"
                            ?
                        Image.asset(
                          "images/bajukurung.png", width: 140.0, height: 140.0,)
                            :
                        widget.detail.iconSelected =="Baju Lengan Panjang"
                            ?
                        Image.asset(
                          "images/shirt.png", width: 140.0, height: 140.0,)
                            :
                        widget.detail.iconSelected =="Seluar."
                            ?
                        Image.asset(
                          "images/seluar.png", width: 140.0, height: 140.0,)
                            :
                        widget.detail.iconSelected =="Baju Melayu"
                            ?
                        Image.asset(
                          "images/bajumelayu.png", width: 140.0, height: 140.0,)
                            :
                        widget.detail.iconSelected =="Baju Lengan Pendek"
                            ?
                        Image.asset(
                          "images/shirtpendek.png", width: 140.0, height: 140.0,)
                            :
                        Image.asset(
                          "images/seluargirl.png", width: 140.0, height: 140.0,),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: SizedBox(
                          height: 1.0,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allWordsCapitilize(widget.detail.nameRecordBy),
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Kategori pakaian: " +
                            widget.detail.clothCategoryByBK,
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Jantina pakaian: " +
                            widget.detail.genderCategoryByBK,
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Kuantiti sumbangan: " +
                                (widget.detail.quantityPending).toString() + " helai",
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 16.0,
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
                            height: 20.0,
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
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          saveAppointmentInfo();
                          saveAppointmentInfo();
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [Colors.pink, Colors.cyanAccent],
                              begin: const FractionalOffset(0.0, 0.0,),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 40.00,
                          height: 50.0,
                          child: Center(
                            child: Text("Set Janji Temu",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveAppointmentInfo() {

    if(_date.isEmpty && _time.isEmpty){
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
      Sumbang.donationRecordByBK: widget.detail.recordBy,
      Sumbang.donationRecordTimeBK: widget.detail.recordTime,
      Sumbang.clothCategory : widget.detail.clothCategoryByBK,
      Sumbang.genderCategory: widget.detail.genderCategoryByBK,
      Sumbang.quantityAppointment: widget.detail.quantityPending,
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
      Sumbang.donationRecordByBK: widget.detail.recordBy,
      Sumbang.donationRecordTimeBK: widget.detail.recordTime,
      Sumbang.clothCategory : widget.detail.clothCategoryByBK,
      Sumbang.genderCategory: widget.detail.genderCategoryByBK,
      Sumbang.quantityAppointment: widget.detail.quantityPending,
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
      Firestore.instance.collection(Sumbang.collectionUserBK)
          .document(widget.detail.recordBy)
          .collection(Sumbang.collectionRecordBK)
          .where("recordTime", isEqualTo: widget.detail.recordTime)
          .getDocuments()
          .then((docs) {
        pendingQuantity = docs.documents[0].data['quantityPending'];

        Firestore.instance.collection(Sumbang.collectionUserBK)
            .document(widget.detail.recordBy)
            .collection(Sumbang.collectionRecordBK)
            .document(widget.detail.recordBy + widget.detail.recordTime).updateData({
          "quantityPending":  widget.detail.quantityPending + pendingQuantity,
        });

      });

    Fluttertoast.showToast(msg: "Tahniah, janji temu sudah berjaya!");

    Route route = MaterialPageRoute(builder: (c) => CharityHubList());
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
        .document(widget.detail.recordBy)
        .collection(Sumbang.collectionRecordBK)
        .document(widget.detail.recordBy + widget.detail.recordTime)
        .collection(Sumbang.collectionAppointmentBK)
        .document((Sumbang.sharedPreferences.getString(Sumbang.userUID) + data['appointmentRecord']))
        .setData(data);

    await Sumbang.firestore
        .collection(Sumbang.collectionAppointmentBKSum)
        .document((Sumbang.sharedPreferences.getString(Sumbang.userUID) + data['appointmentRecord']))
        .setData(data);
  }

}

allWordsCapitilize (String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
