import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/loginErrorDialog.dart';
import 'package:sumbang_sarong/Maps/MapPage.dart';
import 'package:sumbang_sarong/Role_Authorization/userManagement.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Store/home_page.dart';
import 'package:sumbang_sarong/Store/infoDonation.dart';
import 'package:sumbang_sarong/Summary/summaryApp.dart';
import 'package:sumbang_sarong/Summary/test.dart';
import 'package:sumbang_sarong/main.dart';
import 'package:sumbang_sarong/test/sheesh.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.pink, Colors.cyanAccent],
                begin: const FractionalOffset(0.0, 0.0,),
                end: const FractionalOffset(1.0, 0.0),
                stops:[0.0,1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Menu Aplikasi",
                  style: TextStyle(color: Colors.white, fontSize: 35.0, fontFamily: "Signatra"),
                ),

                SizedBox(height: 12.0,),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.pink, Colors.cyanAccent],
                begin: const FractionalOffset(0.0, 0.0,),
                end: const FractionalOffset(1.0, 0.0),
                stops:[0.0,1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home, color: Colors.white,),
                  title: Text("Menu Utama", style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c)=> HomePage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.white, thickness: 6.0,),

                ListTile(
                  leading: Icon(FontAwesomeIcons.donate, color: Colors.white,),
                  title: Text("Info Sumbangan", style: TextStyle(color: Colors.white),),
                  onTap: (){
                    // Route route = MaterialPageRoute(builder: (c)=> sheesh());
                    // Navigator.pushReplacement(context, route);
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
                Divider(height: 10.0, color: Colors.white, thickness: 6.0,),

                ListTile(
                  leading: Icon(Icons.airport_shuttle, color: Colors.white,),
                  title: Text("Senarai Janji Temu", style: TextStyle(color: Colors.white),),
                  onTap: (){
                    FirebaseAuth.instance.currentUser().then((user) {
                      print(user.isAnonymous);
                      if(user.isAnonymous){
                        print(user.uid);
                        displayDialog("Maaf, sila berdaftar sebagai Penyumbang untuk meneruskan sumbangan.");
                      }
                      else{
                        print(user.isEmailVerified);
                        UserManagement().authorizeAccessTemujanjiPenyumbang(context);
                      }
                    });
                  },
                ),
                Divider(height: 10.0, color: Colors.white, thickness: 6.0,),

                ListTile(
                  leading: Icon(FontAwesomeIcons.chartArea, color: Colors.white,),
                  title: Text("Statistik Sumbang Sarong", style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c)=> StatsScreen());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(height: 10.0, color: Colors.white, thickness: 6.0,),

                ListTile(
                  leading: Icon(FontAwesomeIcons.map, color: Colors.white,),
                  title: Text("Peta Lokasi", style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Route route = MaterialPageRoute(builder: (c)=> MapPage());
                    Navigator.pushReplacement(context, route);
                  },
                ),

                Divider(height: 10.0, color: Colors.white, thickness: 6.0,),

                ListTile(
                  leading: Icon(Icons.logout, color: Colors.white,),
                  title: Text("Keluar", style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Sumbang.auth.signOut().then((c){
                      Route route = MaterialPageRoute(builder: (c) => SplashScreen());
                      Navigator.pushReplacement(context, route);});
                  },
                ),

                Divider(height: 10.0, color: Colors.white, thickness: 6.0,),
                SizedBox(height: 400.0,),
              ],
            ),
          ),
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
}
