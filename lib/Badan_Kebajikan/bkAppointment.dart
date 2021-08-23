import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/bkAppointmentCard.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Widgets/loadingWidget.dart';

class BKAppointment extends StatefulWidget {
  @override
  _MyAppointmentState createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<BKAppointment> {
  @override
  Widget build(BuildContext context) {
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
          title: Text(
            "Senarai Janji Temu",
            style: TextStyle(color: Colors.white),
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
        body: StreamBuilder<QuerySnapshot>(
          stream: Sumbang.firestore
              .collection(Sumbang.collectionAppointmentBKSum)
              .where("donationRecordByBK", isEqualTo: Sumbang.sharedPreferences.getString(Sumbang.userUIDBK))
              .snapshots(),
          builder: (c, snapshot) {
            if(snapshot.data == null) return Center(child: Text("Tiada rekod", style: TextStyle(color: Colors.pink, fontSize: 20.0),),);
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (c, index) {
                      return FutureBuilder<QuerySnapshot>(
                        future: Firestore.instance
                            .collection(Sumbang.collectionUserBK)
                            .document(snapshot.data.documents[index]
                                .data[Sumbang.donationRecordByBK])
                            .collection(Sumbang.collectionRecordBK)
                            .document(snapshot.data.documents[index]
                                    .data[Sumbang.donationRecordByBK] +
                                snapshot.data.documents[index]
                                    .data[Sumbang.donationRecordTimeBK])
                            .collection(Sumbang.collectionAppointmentBK)
                            .where("appointmentRecord", isEqualTo: snapshot.data.documents[index].data[Sumbang.appointmentRecord])
                            .getDocuments(),
                        builder: (c, snap) {
                          return snap.hasData
                              ? BKAppointmentCard(
                                  itemCount: snap.data.documents.length,
                                  data: snap.data.documents,
                                  appointmentID:
                                      snapshot.data.documents[index].documentID,
                                )
                              : Center(
                                  child: circularProgress(),
                                );
                        },
                      );
                    },
                  )
                : Center(
                    child: circularProgress(),
                  );
          },
        ),
      ),
    );
  }
}
