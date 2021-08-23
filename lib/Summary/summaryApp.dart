import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';
import 'package:flutter/material.dart';

String getAppointmentId = "";

class SummaryApp extends StatefulWidget {
  @override
  _SummaryAppState createState() => _SummaryAppState();
}

class _SummaryAppState extends State<SummaryApp> {
  @override
  Widget build(BuildContext context) {

    var totalToDonate = 0;
    var totalToDonateInBK = 0;
    var totalDelivered = 0;
    var appointRecord = 0;
    var totalCurrentStock = 0;
    var totalStock = 0;

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
            Route route = MaterialPageRoute(builder: (c)=> CharityHubList());
            Navigator.pushReplacement(context, route);
          },
          ),
          centerTitle: true,
          title: Text(
            "Laporan Sumbang Sarong",
            style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<QuerySnapshot>(
            future: Sumbang.firestore
                .collection(Sumbang.collectionDetailRecordBK)
                .getDocuments(),
            builder: (c, dataSnapshot) {
              if(dataSnapshot.data == null) return circularProgress();
              dataSnapshot.data.documents.forEach((doc) {
                totalStock += doc.data["quantityByBK"];
                print("ini adalah " + doc.data['quantityByBK'].toString());
              });
              return dataSnapshot.hasData
                  ? Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    "TOTAL STOCK: " +
                                        totalStock.toString(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 2.0,
                          ),
                          FutureBuilder<QuerySnapshot>(
                            future: Sumbang.firestore
                                .collection(Sumbang.collectionAppointmentBKSum)
                                .getDocuments(),
                            builder: (c, snap) {
                              if(snap.data == null) return circularProgress();
                              snap.data.documents.forEach((docs) {

                                totalToDonateInBK += docs.data["quantityAppointment"];
                                totalCurrentStock = totalStock - totalToDonateInBK;
                                totalToDonate = snap.data.documents.length;

                                print("ini totalStock " + totalStock.toString());
                                print("ini totalToDonateInBK " + totalToDonateInBK.toString());
                              });
                              return snap.hasData
                                  ? Container(
                                    child: Column(
                                      children: [
                                        Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "CURRENT STOCK: " +
                                                        totalCurrentStock.toString(),
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 14.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                      "TO DONATE: " +
                                                          totalToDonate.toString(),
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 14.0),
                                                    ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        Divider(
                                          height: 2.0,
                                        ),
                                        FutureBuilder<QuerySnapshot>(
                                          future: Sumbang.firestore
                                              .collection(Sumbang.collectionAppointmentSum)
                                              .getDocuments(),
                                          builder: (c, shot) {
                                            if(shot.data == null) return circularProgress();
                                            appointRecord = shot.data.documents.length;
                                            totalDelivered = appointRecord - totalToDonate;

                                            return shot.hasData
                                                ? Container(
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "TO DELIVERED: " +
                                                          totalDelivered.toString(),
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
