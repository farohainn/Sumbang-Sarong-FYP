import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/loginErrorDialog.dart';
import 'package:sumbang_sarong/Models/charityHubModel.dart';
import 'package:sumbang_sarong/Store/donationRecord.dart';
import 'package:sumbang_sarong/Store/lelaki.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';
import 'package:sumbang_sarong/Widgets/myDrawer.dart';
import 'package:sumbang_sarong/test/sheesh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    var totalRecord =0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.pink,
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.donate, size: 30.0, color: Colors.black,),
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
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 380,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image(
                    image: AssetImage("images/where.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.listUl,
                          size: 15.0,
                          color: Colors.black45,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "Senarai rumah kebajikan",
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          FutureBuilder<QuerySnapshot>(
            future: Sumbang.firestore
                .collection(Sumbang.collectionUserBK)
                .getDocuments(),
            builder: (c, dataSnapshot) {
              if (dataSnapshot.data == null) return circularProgress();
              return dataSnapshot.hasData
                  ? Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                        itemCount: dataSnapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          CharityModel model = CharityModel.fromJson(
                              dataSnapshot.data.documents[index].data);
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (_) => DonationRecord(charityModel: model),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                                  height: 200.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        100.0, 20.0, 20.0, 20.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 120.0,
                                              child: Text(
                                                model.nameNewBK,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            FutureBuilder<QuerySnapshot>(
                                              future: Sumbang.firestore
                                                  .collection(
                                                      Sumbang.collectionUserBK)
                                                  .where("uidNewBK",
                                                      isEqualTo: model.uidNewBK)
                                                  .getDocuments(),
                                              builder: (c, shot) {
                                                if(shot.data == null) return circularProgress();
                                                shot.data.documents
                                                    .forEach((docs) {
                                                      totalRecord =
                                                      docs.data["totalQuantity"];
                                                });
                                                return shot.hasData
                                                    ? Column(
                                                        children: <Widget>[
                                                          Text(
                                                            totalRecord
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            'helai',
                                                            style: TextStyle(
                                                              color: Colors.grey,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Center(
                                                        child: circularProgress(),
                                                      );
                                              },
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 170.0,
                                          child: Text(
                                            model.emailNewBK,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13.0,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        Text(
                                          model.phoneNewBK,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          padding: EdgeInsets.all(5.0),
                                          width: 200.0,
                                          decoration: BoxDecoration(
                                            color: Colors.cyan,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            model.addressNewBK,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20.0,
                                  top: 15.0,
                                  bottom: 15.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image(
                                      width: 110.0,
                                      image: AssetImage(
                                        "images/icon.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: circularProgress(),
                    );
            },
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
