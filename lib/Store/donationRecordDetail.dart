import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/loginErrorDialog.dart';
import 'package:sumbang_sarong/Models/charityHubModel.dart';
import 'package:sumbang_sarong/Models/item.dart';
import 'package:sumbang_sarong/Role_Authorization/userManagement.dart';
import 'package:sumbang_sarong/Store/toDonate.dart';
import 'package:sumbang_sarong/test/sheesh.dart';

class DonationDetail extends StatefulWidget {
  final ItemModel donate;
  final CharityModel charity;

  DonationDetail({this.donate, this.charity});

  @override
  _DonationDetailState createState() => _DonationDetailState();
}

class _DonationDetailState extends State<DonationDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 60.0,
                    ),
                    height: 520.0,
                    color: Colors.pinkAccent[700],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
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
                              child: Icon(
                                  FontAwesomeIcons.donate,
                                size: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          widget.donate.genderCategoryByBK.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.donate.clothCategoryByBK,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Text(
                          'KUANTITI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          widget.donate.quantityByBK.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Text(
                          'RUMAH KEBAJIKAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          width: 200.0,
                          child: Text(
                            widget.charity.nameNewBK,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        RawMaterialButton(
                          padding: EdgeInsets.all(20.0),
                          shape: CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.cyan,
                          child: Icon(
                            FontAwesomeIcons.donate,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) =>
                            //         ToDonate(charity: widget.charity, model: widget.donate),
                            //   ),
                            // );
                            FirebaseAuth.instance.currentUser().then((user) {
                              print(user.isAnonymous);
                              if(user.isAnonymous){
                                print(user.uid);
                                displayDialog("Maaf, sila berdaftar sebagai Penyumbang untuk meneruskan sumbangan.");
                              }
                              else{
                                print(user.isEmailVerified);
                                UserManagement().authorizeAccessPenyumbang(widget.charity, widget.donate, context);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  widget.donate.clothCategoryByBK =="Baju Melayu"
                      ?
                  Positioned(
                    right: 0.0,
                    left: 200.0,
                    bottom: 30.0,
                    child:
                    Image(
                      height: 200.0,
                      width: 200.0,
                      image: AssetImage("images/baju1.png"),
                    ),
                  )
                      :
                  widget.donate.clothCategoryByBK =="Seluar."
                      ?
                  Positioned(
                    right: 0.0,
                    left: 200.0,
                    bottom: 30.0,
                    child:
                    Image(
                      height: 280.0,
                      width: 280.0,
                      image: AssetImage("images/baju2.png"),
                    ),
                  )
                      :
                  widget.donate.clothCategoryByBK =="Baju Lengan Pendek"
                      ?
                  Positioned(
                    right: 0.0,
                    left: 200.0,
                    bottom: 30.0,
                    child:
                    Image(
                      height: 180.0,
                      width: 180.0,
                      image: AssetImage("images/baju3.png"),
                    ),
                  )
                      :
                  widget.donate.clothCategoryByBK =="Baju Kurung"
                      ?
                  Positioned(
                    right: 0.0,
                    left: 200.0,
                    bottom: 30.0,
                    child:
                    Image(
                      height: 280.0,
                      width: 280.0,
                      image: AssetImage("images/baju4.png"),
                    ),
                  )
                      :
                  widget.donate.clothCategoryByBK =="Seluar"
                      ?
                  Positioned(
                    right: 0.0,
                    left: 200.0,
                    bottom: 30.0,
                    child:
                    Image(
                      height: 200.0,
                      width: 200.0,
                      image: AssetImage("images/baju5.png"),
                    ),
                  )
                      :
                  widget.donate.clothCategoryByBK =="Baju Lengan Panjang"
                      ?
                  Positioned(
                    right: 0.0,
                    left: 200.0,
                    bottom: 30.0,
                    child:
                    Image(
                      height: 280.0,
                      width: 280.0,
                      image: AssetImage("images/baju6.png"),
                    ),
                  )
                      :
                  CircularProgressIndicator(),
                ],
              ),
              Container(
                height: 400.0,
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        top: 40.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Maklumat keperluan sumbangan ..',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Kuantiti keperluan sumbangan adalah mengikut yang telah ditetapkan oleh rumah kebajikan. Terdapat "+
                            widget.donate.quantityPending.toString() + " helai yang belum diterima kerana sumbangan melalui aplikasi telah dilakukan oleh penyumbang.",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Perincian rumah kebajikan',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            widget.charity.nameNewBK,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            widget.charity.phoneNewBK,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            widget.charity.emailNewBK,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            widget.charity.addressNewBK,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
