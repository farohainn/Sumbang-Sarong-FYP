import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/Models/charityHubModel.dart';
import 'package:sumbang_sarong/Store/chooseGender.dart';
import 'package:sumbang_sarong/Widgets/customAppBar.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';
import 'package:sumbang_sarong/Widgets/myDrawer.dart';
import 'package:sumbang_sarong/Widgets/searchBox.dart';

double width;

class CharityHubList extends StatefulWidget {
  final int itemCount;

  CharityHubList({Key key, this.itemCount}) : super(key: key);

  @override
  _CharityHubListState createState() => _CharityHubListState();
}

class _CharityHubListState extends State<CharityHubList> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>(
              stream:
                  Firestore.instance.collection(Sumbang.collectionUserBK).snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          CharityModel model = CharityModel.fromJson(
                              dataSnapshot.data.documents[index].data);
                          return sourceInfo(model, context);
                        },
                        itemCount: dataSnapshot.data.documents.length,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget sourceInfo(CharityModel model, BuildContext context,
      {Color background, removeCartFunction}) {
    //return Scaffold();
    return InkWell(
      onTap: () {
        Route route = MaterialPageRoute(
            builder: (c) => ChooseGender(charityModel: model));
        Navigator.pushReplacement(context, route);
      },
      splashColor: Colors.pink,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          height: 190.0,
          width: width,
          child: Row(
            children: [
              Icon(
                Icons.home_work_rounded,
                size: 140.0,
                color: Colors.grey[400],
              ),
              SizedBox(
                width: 4.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            allWordsCapitilize(model.nameNewBK),
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "No Tel:  " + (model.phoneNewBK).toString(),
                            style: TextStyle(
                                color: Colors.black54, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Emel: " + model.emailNewBK,
                            style: TextStyle(
                                color: Colors.black54, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              "Alamat: " + (model.addressNewBK),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              "Keseluruhan kuantiti keperluan sumbangan: " ,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // FutureBuilder<QuerySnapshot>(
                    //   future: Sumbang.firestore
                    //       .collection(Sumbang.collectionUserBK)
                    //       .document(model.uidNewBK)
                    //       .collection(Sumbang.collectionRecordBK)
                    //       .where("recordBy", isEqualTo: model.uidNewBK)
                    //       .getDocuments(),
                    //   builder: (c, dataSnapshot) {
                    //     dataSnapshot.data.documents.forEach((doc) {
                    //       setState(() {
                    //         totalDonateRecord += int.parse(doc.data["quantityByBK"]);
                    //         print("aaaaaa" + totalDonateRecord.toString());
                    //         print("bbbbbbb" + doc.data["quantityByBK"]);
                    //       });
                    //     });
                    //     return dataSnapshot.hasData
                    //         ? Container(
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 Expanded(
                    //                   child: Text(
                    //                     "Keseluruhan kuantiti keperluan sumbangan: " +
                    //                         totalDonateRecord.toString(),
                    //                     maxLines: 3,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: TextStyle(
                    //                         color: Colors.black54,
                    //                         fontSize: 14.0),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           )
                    //         : Container(
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 Expanded(
                    //                   child: Text(
                    //                     "Keseluruhan kuantiti keperluan sumbangan: 0",
                    //                     maxLines: 3,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: TextStyle(
                    //                         color: Colors.black54,
                    //                         fontSize: 14.0),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //   },
                    // ),
                    Flexible(
                      child: Container(),
                    ),
                    Divider(
                      color: Colors.pink,
                      height: 10.0,
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
}

allWordsCapitilize(String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}
