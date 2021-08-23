import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/loginErrorDialog.dart';
import 'package:sumbang_sarong/Models/charityHubModel.dart';
import 'package:sumbang_sarong/Models/item.dart';
import 'package:sumbang_sarong/Store/donationRecordDetail.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';
import 'package:sumbang_sarong/Widgets/myDrawer.dart';
import 'package:sumbang_sarong/test/sheesh.dart';

class DonationRecord extends StatefulWidget {
  final CharityModel charityModel;

  DonationRecord({
    Key key,
    this.charityModel,
  }) : super(key: key);

  @override
  _DonationRecordState createState() => _DonationRecordState();
}

class _DonationRecordState extends State<DonationRecord>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  PageController _pageController;
  bool category= true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  _donationRecordLelakiSelector(BuildContext context, ItemModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DonationDetail(donate: model, charity: widget.charityModel),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.pinkAccent[700],
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
            child: Stack(
              children: <Widget>[
                model.clothCategoryByBK =="Baju Melayu"
                    ?
                Center(
                  child: Image(
                      height: 250.0,
                      width: 250.0,
                      image: AssetImage(
                          "images/baju1.png"
                      )
                    //fit: BoxFit.cover,
                  ),
                )
                    :
                model.clothCategoryByBK =="Seluar."
                    ?
                Center(
                  child: Image(
                      height: 250.0,
                      width: 250.0,
                      image: AssetImage(
                          "images/baju2.png"
                      )
                    //fit: BoxFit.cover,
                  ),
                )
                    :
                model.clothCategoryByBK =="Baju Lengan Pendek"
                    ?
                Center(
                  child: Image(
                      height: 250.0,
                      width: 250.0,
                      image: AssetImage(
                          "images/baju3.png"
                      )
                    //fit: BoxFit.cover,
                  ),
                )
                    :
                CircularProgressIndicator(),
                Positioned(
                  top: 30.0,
                  right: 30.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'KUANTITI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        model.quantityByBK.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30.0,
                  bottom: 40.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.genderCategoryByBK.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        model.clothCategoryByBK,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 4.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.cyan,
              child: Icon(
                FontAwesomeIcons.donate,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () => print('Sumbang'),
            ),
          ),
        ],
      ),
    );
  }

  _donationRecordPerempuanSelector(BuildContext context, ItemModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DonationDetail(donate: model, charity: widget.charityModel),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.pinkAccent[700],
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
            child: Stack(
              children: <Widget>[
                model.clothCategoryByBK =="Baju Kurung"
                    ?
                Center(
                  child: Image(
                    height: 250.0,
                    width: 250.0,
                    image: AssetImage(
                        "images/baju4.png"
                    ),
                    //fit: BoxFit.cover,
                  ),
                )
                    :
                model.clothCategoryByBK =="Seluar"
                    ?
                Center(
                  child: Image(
                    height: 250.0,
                    width: 250.0,
                    image: AssetImage(
                        "images/baju5.png"
                    ),
                    //fit: BoxFit.cover,
                  ),
                )
                    :
                model.clothCategoryByBK =="Baju Lengan Panjang"
                    ?
                Center(
                  child: Image(
                    height: 250.0,
                    width: 250.0,
                    image: AssetImage(
                        "images/baju6.png"
                    ),
                    //fit: BoxFit.cover,
                  ),
                )
                    :
                CircularProgressIndicator(),
                Positioned(
                  top: 30.0,
                  right: 30.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'KUANTITI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        model.quantityByBK.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 30.0,
                  bottom: 40.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.genderCategoryByBK.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        model.clothCategoryByBK,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 4.0,
            child: RawMaterialButton(
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.cyan,
              child: Icon(
                FontAwesomeIcons.donate,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () => print('Sumbang'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey,
          size: 30.0,
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: ListView(
          //padding: EdgeInsets.symmetric(vertical: 60.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                'Keperluan Sumbangan',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.withOpacity(0.6),
              labelPadding: EdgeInsets.symmetric(horizontal: 35.0),
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Lelaki',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Perempuan',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // TabBarView(
            //   controller: _tabController,
            //   children: [
            //     _donationRecordLelakiSelector(context, ItemModel()),
            //     _donationRecordPerempuanSelector(context, ItemModel()),
            //   ],
            // ),
            SizedBox(height: 20.0),
            FutureBuilder<QuerySnapshot>(
              future: Sumbang.firestore
                  .collection(Sumbang.collectionUserBK)
                  .document(widget.charityModel.uidNewBK)
                  .collection(Sumbang.collectionRecordBK)
                  .where("recordBy", isEqualTo: widget.charityModel.uidNewBK)
                  .getDocuments(),
              builder: (c, shot) {
                return !shot.hasData
                    ? Center(
                  child: circularProgress(),
                )
                    : Container(
                  height: 500.0,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: shot.data.documents.length, //itemCount: plants.length,
                    itemBuilder: (BuildContext context, index) {
                      ItemModel model = ItemModel.fromJson(shot.data.documents[index].data);
                      if (model.genderCategoryByBK == "Lelaki"){
                        return _donationRecordLelakiSelector(context, model);
                      } else if (model.genderCategoryByBK == "Perempuan"){
                        return _donationRecordPerempuanSelector(context, model);
                      }//return _plantSelector(index);
                      return circularProgress();
                    },
                  ),
                );
              },
            ),
          ],
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
