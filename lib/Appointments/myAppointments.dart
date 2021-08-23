import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:flutter/services.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:sumbang_sarong/Store/home_page.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/appointmentCard.dart';

class MyAppointments extends StatefulWidget {
  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
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
                begin: const FractionalOffset(0.0, 0.0,),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    HomePage(),
              ),
            );
          },
          ),
          centerTitle: true,
          title: Text(
            "Senarai Janji Temu",
            style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
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
              .collection(Sumbang.collectionUser)
              .document(Sumbang.sharedPreferences.getString(Sumbang.userUID))
              .collection(Sumbang.collectionAppointment)
              .snapshots(),
          builder: (c, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (c, index) {
                      return FutureBuilder<QuerySnapshot>(
                        future: Firestore.instance
                            .collection(Sumbang.collectionAppointmentSum)
                            .where("appointmentRecord", isEqualTo: snapshot.data.documents[index].data[Sumbang.appointmentRecord])
                            .getDocuments(),
                        builder: (c, snap) {
                          return snap.hasData
                              ? AppointmentCard(
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
