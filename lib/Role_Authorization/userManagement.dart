import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Appointments/myAppointments.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/Models/charityHubModel.dart';
import 'package:sumbang_sarong/Models/item.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:sumbang_sarong/Store/home_page.dart';
import 'package:sumbang_sarong/Store/product_page.dart';
import 'package:sumbang_sarong/Store/toDonate.dart';
import 'package:sumbang_sarong/main.dart';


class UserManagement {
  Widget handleAuth() {
    return new StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        return snapshot.hasData
            ? HomePage()
            : SplashScreen();
      },
    );
  }

  authorizeAccessPenyumbang(CharityModel charity ,ItemModel model, BuildContext context) {

    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance.collection(Sumbang.collectionUser)
          .where("uid", isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'penyumbang') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ToDonate(charity: charity, model: model),
              ),
            );
          }
        }
      });
    });
  }

  authorizeAccessTemujanjiPenyumbang(BuildContext context) {

    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance.collection(Sumbang.collectionUser)
          .where("uid", isEqualTo: user.uid)
          .getDocuments()
          .then((docs) {
        if (docs.documents[0].exists) {
          if (docs.documents[0].data['role'] == 'penyumbang') {
            Route route = MaterialPageRoute(builder: (c)=> MyAppointments());
            Navigator.pushReplacement(context, route);
          }
        }
      });
    });
  }
}
