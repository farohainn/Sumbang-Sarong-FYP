import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/loginErrorDialog.dart';
import 'package:sumbang_sarong/Summary/grid.dart';
import 'package:sumbang_sarong/Summary/pie.dart';
import 'package:sumbang_sarong/Widgets/myDrawer.dart';
import 'package:sumbang_sarong/test/sheesh.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent[700],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 30.0,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.donate, size: 30.0, color: Colors.white,),
                onPressed: (){
                  FirebaseAuth.instance.currentUser().then((user) {
                    print(user.isAnonymous);
                    if(user.isAnonymous){
                      print(user.uid);
                      displayDialog("Maaf, sila berdaftar sebagai Penyumbang untuk meneruskan sumbangan.");
                    }
                    else{
                      print(user.isEmailVerified);
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
                                      InfoDonation(),
                                ),
                              );
                            }
                          }
                        });
                      });
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.only(top: 20.0),
          //   sliver: SliverToBoxAdapter(
          //     child: CovidBarChart(),
          //   ),
          // ),
        ],
      ),
    );
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return LoginErrorAlertDialog(message: msg,);
        }
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Statistik',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}