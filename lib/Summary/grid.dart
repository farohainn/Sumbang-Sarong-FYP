import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';

class StatsGrid extends StatelessWidget {
  var totalStock=0;
  var totalToDonateInBK=0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: <Widget>[
          FutureBuilder<QuerySnapshot>(
              future: Sumbang.firestore
                  .collection(Sumbang.collectionAppointmentSum)
                  .getDocuments(),
              builder: (c, snap) {
                return !snap.hasData
                    ? circularProgress()
                    : Flexible(
                        child: Row(
                          children: <Widget>[
                            _buildStatCard(
                                'Jumlah Penyumbang Membuat Sumbangan',
                                snap.data.documents.length.toString(),
                                Colors.orange),
                            FutureBuilder<QuerySnapshot>(
                                future: Sumbang.firestore
                                    .collection(
                                        Sumbang.collectionAppointmentBKSum)
                                    .getDocuments(),
                                builder: (c, shot) {
                                  return !shot.hasData
                                      ? circularProgress()
                                      : _buildStatCard(
                                          'Jumlah Janji Temu Serahan Sumbangan Disahkan',
                                          (snap.data.documents.length - shot.data.documents.length)
                                              .toString(),
                                          Colors.green);
                                }),
                          ],
                        ),
                      );
              }),
          FutureBuilder<QuerySnapshot>(
              future: Sumbang.firestore
                  .collection(Sumbang.collectionDetailRecordBK)
                  .getDocuments(),
              builder: (c, dataSnapshot) {
                if(dataSnapshot.data == null) return circularProgress();
                dataSnapshot.data.documents.forEach((doc) {
                  totalStock += doc.data["quantityByBK"];
                });
                return !dataSnapshot.hasData
                    ? circularProgress()
                    : Flexible(
                        child: Row(
                          children: <Widget>[
                            _buildStatCard('Jumlah Keseluruhan Keperluan Pakaian',totalStock.toString() + " Helai", Colors.lightBlue),
                            FutureBuilder(
                                future: Sumbang.firestore
                                    .collection(Sumbang.collectionAppointmentSum)
                                    .getDocuments(),
                                builder: (c, snaps) {
                                  if(snaps.data == null) return circularProgress();
                                  snaps.data.documents.forEach((docs) {
                                    totalToDonateInBK += docs.data["quantityAppointment"];
                                  });
                                  return !snaps.hasData
                                      ? circularProgress()
                                      :  _buildStatCard('Jumlah Sumbangan Pakaian Terkini', totalToDonateInBK.toString() + " Helai", Colors.purple);
                                }),
                          ],
                        ),
                      );
              }),
          FutureBuilder<QuerySnapshot>(
              future: Sumbang.firestore
                  .collection(Sumbang.collectionUser)
                  .getDocuments(),
              builder: (c, datasnap) {
                return !datasnap.hasData
                    ? circularProgress()
                    : Flexible(
                  child: Row(
                    children: <Widget>[
                      _buildStatCard('Jumlah Penyumbang Berdaftar',datasnap.data.documents.length.toString(), Colors.teal),
                      FutureBuilder(
                          future: Sumbang.firestore
                              .collection(Sumbang.collectionUserBK)
                              .getDocuments(),
                          builder: (c, snaps) {
                            return !snaps.hasData
                                ? circularProgress()
                                :  _buildStatCard('Jumlah Badan Kebajikan Berdaftar', snaps.data.documents.length.toString(), Colors.blueGrey);
                          }),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
