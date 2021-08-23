import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/Models/charityHubModel.dart';
import 'package:sumbang_sarong/Models/item.dart';
import 'package:sumbang_sarong/Store/donationRecordDetail.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Lelaki(),
    );
  }
}

class Lelaki extends StatefulWidget {
  final CharityModel charityModel;

  Lelaki({this.charityModel});
  @override
  _LelakiState createState() => _LelakiState();
}

class _LelakiState extends State<Lelaki> {
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
        future: Sumbang.firestore
            .collection(Sumbang.collectionUserBK)
            .document(widget.charityModel.uidNewBK)
            .collection(Sumbang.collectionRecordBK)
            .where("recordBy", isEqualTo: widget.charityModel.uidNewBK)
            .where("genderCategoryByBK", isEqualTo: "Lelaki")
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
                    itemCount:
                        shot.data.documents.length, //itemCount: plants.length,
                    itemBuilder: (BuildContext context, index) {
                      ItemModel model =
                          ItemModel.fromJson(shot.data.documents[index].data);
                      return _donationRecordLelakiSelector(context, model);
                    },
                  ),
                );
        },
      ),
    );
  }

  _donationRecordLelakiSelector(BuildContext context, ItemModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                DonationDetail(donate: model, charity: widget.charityModel),
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
                model.clothCategoryByBK == "Baju Melayu"
                    ? Center(
                        child: Image(
                            height: 250.0,
                            width: 250.0,
                            image: AssetImage("images/baju1.png")
                            //fit: BoxFit.cover,
                            ),
                      )
                    : model.clothCategoryByBK == "Seluar."
                        ? Center(
                            child: Image(
                                height: 250.0,
                                width: 250.0,
                                image: AssetImage("images/baju2.png")
                                //fit: BoxFit.cover,
                                ),
                          )
                        : model.clothCategoryByBK == "Baju Lengan Pendek"
                            ? Center(
                                child: Image(
                                    height: 250.0,
                                    width: 250.0,
                                    image: AssetImage("images/baju3.png")
                                    //fit: BoxFit.cover,
                                    ),
                              )
                            : CircularProgressIndicator(),
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
}
