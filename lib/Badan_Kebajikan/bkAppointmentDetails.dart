import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sumbang_sarong/Appointments/AppointmentDetailsPage.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/SaveItem.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/bkAppointment.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/bkAppointmentCard.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/Models/appointment.dart';
import 'package:sumbang_sarong/Models/penyumbang.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';

String getAppointmentId = "";

class BKAppointmentDetails extends StatelessWidget {
  final String appointmentID;
  final String appointmentBy;

  BKAppointmentDetails({
    Key key,
    this.appointmentID,
    this.appointmentBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAppointmentId = appointmentID;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.pink, Colors.cyanAccent],
                begin: const FractionalOffset(
                  0.0,
                  0.0,
                ),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Route route = MaterialPageRoute(builder: (c) => BKAppointment());
              Navigator.pushReplacement(context, route);
            },
          ),
          centerTitle: true,
          title: Text(
            "Perincian Janji Temu",
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
            future: Sumbang.firestore
                .collection(Sumbang.collectionAppointmentBKSum)
                .document(appointmentID)
                .get(),
            builder: (c, snapshot) {
              Map dataMap;
              if (snapshot.hasData) {
                dataMap = snapshot.data.data;
              }
              return snapshot.hasData
                  ? Container(
                      child: Column(
                        children: [
                          BKStatusBanner(
                            status: dataMap[Sumbang.isSuccess],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "Set janji temu pada: " +
                                  DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          int.parse(
                                              dataMap["appointmentRecord"]))),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16.0),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          FutureBuilder<QuerySnapshot>(
                            future: Sumbang.firestore
                                .collection(Sumbang.collectionUserBK)
                                .document(dataMap[Sumbang.donationRecordByBK])
                                .collection(Sumbang.collectionRecordBK)
                                .document(dataMap[Sumbang.donationRecordByBK] +
                                    dataMap[Sumbang.donationRecordTimeBK])
                                .collection(Sumbang.collectionAppointmentBK)
                                .where("appointmentRecord", isEqualTo: dataMap[Sumbang.appointmentRecord])
                                .getDocuments(),
                            builder: (c, dataSnapshot) {
                              return dataSnapshot.hasData
                                  ? BKAppointmentCard(
                                      itemCount:
                                          dataSnapshot.data.documents.length,
                                      data: dataSnapshot.data.documents,
                                    )
                                  : Center(
                                      child: circularProgress(),
                                    );
                            },
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          FutureBuilder<DocumentSnapshot>(
                            future: Sumbang.firestore
                                .collection(Sumbang.collectionUser)
                                .document(dataMap["appointmentBy"])
                                .get(),
                            builder: (c, snap) {
                              return snap.hasData
                                  ? PenyumbangDetails(
                                      model:
                                          Penyumbang.fromJson(snap.data.data),
                                    )
                                  : Center(
                                      child: circularProgress(),
                                    );
                            },
                          ),
                          FutureBuilder<DocumentSnapshot>(
                            future: Sumbang.firestore
                                .collection(Sumbang.collectionAppointmentBKSum)
                                .document(dataMap["appointmentBy"] + dataMap[Sumbang.appointmentRecord])
                                .get(),
                            builder: (c, shot) {
                              return shot.hasData
                                  ? Button(
                                      model1:
                                      AppointModel.fromJson(shot.data.data),
                                    )
                                  : Center(
                                      child: circularProgress(),
                                    );
                            },
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: circularProgress(),
                    );
            },
          ),
        ),
      ),
    );
  }
}

class BKStatusBanner extends StatelessWidget {
  final bool status;

  BKStatusBanner({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String msg;
    IconData iconData;

    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? msg = "Berjaya" : msg = "Tidak Bejaya";

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.pink, Colors.cyanAccent],
          begin: const FractionalOffset(
            0.0,
            0.0,
          ),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Container(
              child: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            "Set Janji Temu " + msg,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 5.0,
          ),
          CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.grey,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PenyumbangDetails extends StatelessWidget {
  final Penyumbang model;

  PenyumbangDetails({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Text(
            "Maklumat Penyumbang:",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 5.0),
          width: screenWidth,
          child: Table(
            children: [
              TableRow(children: [
                KeyText(
                  msg: "Nama",
                ),
                Text(allWordsCapitilize(model.name)),
              ]),
              TableRow(children: [
                KeyText(
                  msg: "Nombor Telefon",
                ),
                Text(model.phone),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final AppointModel model1;

  Button({Key key, this.model1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: () {
                confirmParcelShifted(
                    context, model1.donationRecordByBK, model1.donationRecordTimeBK, model1.quantityAppointment, getAppointmentId);
              },
              child: Container(
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    colors: [Colors.pink, Colors.cyanAccent],
                    begin: const FractionalOffset(
                      0.0,
                      0.0,
                    ),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Sumbangan Telah Diterima",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  confirmParcelShifted(
      BuildContext context, String recordBy, String recordTime, int quantityAppointment, String mAppointmentId) async {

    //read mAppointmentId

    print("ini adalah penentuan " + recordBy + recordTime);

    int total=0;
    Sumbang.firestore.collection(Sumbang.collectionUserBK)
        .document(recordBy)
        .get().then((doc){
      total= doc.data['totalQuantity'];

      Sumbang.firestore.collection(Sumbang.collectionUserBK)
          .document(recordBy)
          .updateData({
        "totalQuantity": quantityAppointment + total
      });
    });

    Firestore.instance
        .collection(Sumbang.collectionUserBK)
        .document(recordBy)
        .collection(Sumbang.collectionRecordBK)
        .where(FieldPath.documentId,
        isEqualTo: recordBy + recordTime)
        .getDocuments()
        .then((docs) {
      if (docs.documents[0].exists) {
        int currentQuantity = docs.documents[0].data['quantityByBK'] - quantityAppointment;
        int currentPendingQuantity = docs.documents[0].data['quantityPending'] - quantityAppointment;

        print("ini adalah penentuan " + docs.documents[0].data['recordBy']);
        print("ini quantityByBK " + (docs.documents[0].data['quantityByBK']).toString());
        print("ini quantityPending " + quantityAppointment.toString());
        print("ini currentQuantity " + currentQuantity.toString());
        print("ini currentPendingQuantity " +
            currentPendingQuantity.toString());

      Sumbang.firestore
          .collection(Sumbang.collectionUserBK)
          .document(recordBy)
          .collection(Sumbang.collectionRecordBK)
          .document(recordBy + recordTime)
          .updateData({
        "quantityByBK": currentQuantity,
        "quantityPending": currentPendingQuantity
      });

      if (currentQuantity == 0){
        Sumbang.firestore
            .collection(Sumbang.collectionUserBK)
            .document(recordBy)
            .collection(Sumbang.collectionRecordBK)
            .document(recordBy + recordTime)
            .delete();
      }

      Sumbang.firestore
          .collection(Sumbang.collectionUserBK)
          .document(recordBy)
          .collection(Sumbang.collectionRecordBK)
          .document(recordBy + recordTime)
          .collection(Sumbang.collectionAppointmentBK)
          .document(mAppointmentId)
          .delete();

      Sumbang.firestore
          .collection(Sumbang.collectionAppointmentBKSum)
          .document(mAppointmentId)
          .delete();
      } else {
        print("error alert!!");
      }
    });


    getAppointmentId = "";

    Route route = MaterialPageRoute(builder: (c) => SaveItem());
    Navigator.pushReplacement(context, route);

    Fluttertoast.showToast(msg: "Tahniah, sumbangan telah sampai!");
  }
}