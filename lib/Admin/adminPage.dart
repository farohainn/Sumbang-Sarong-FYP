import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/Models/adminItem.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';
import 'package:sumbang_sarong/Widgets/searchBox.dart';
import '../main.dart';
import 'details.dart';

double width;

class AdminPage extends StatefulWidget
{
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with AutomaticKeepAliveClientMixin<AdminPage>
{
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return displayAdminHomeScreen();
  }

  displayAdminHomeScreen(){
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.pink, Colors.cyanAccent],
              begin: const FractionalOffset(
                0.0,
                0.0,
              ),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {

          },
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Sumbang.auth.signOut().then((c){
                Route route = MaterialPageRoute(builder: (c) => SplashScreen());
                Navigator.pushReplacement(context, route);});
            },
            child: Text(
              "Log Keluar",
              style: TextStyle(
                color: Colors.pink,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("permohonan").snapshots(),
            builder: (context, dataSnapshot){
              return !dataSnapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : SliverStaggeredGrid.countBuilder(
                crossAxisCount: 1,
                staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                itemBuilder: (context, index){
                  AdminInfoModel model = AdminInfoModel.fromJson(dataSnapshot.data.documents[index].data);
                  return sourceInfo(model, context);
                },
                itemCount: dataSnapshot.data.documents.length,
              );
            },
          ),
        ],
      ),
    );
  }

}

Widget sourceInfo(AdminInfoModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  //return Scaffold();
  return InkWell(
    onTap: (){
      Route route = MaterialPageRoute(builder: (c) => InfoDetails(infoModel: model));
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
            Icon(Icons.home_work_rounded, size: 140.0, color: Colors.grey[400],),
            SizedBox(width: 4.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0,),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Nama: " + allWordsCapitilize(model.nameBK), style: TextStyle(color: Colors.black, fontSize: 16.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("No Tel:  " + (model.phoneBK).toString(), style: TextStyle(color: Colors.black54, fontSize: 14.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0,),

                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Emel: " + model.emailBK,
                          style: TextStyle(color: Colors.black54, fontSize: 14.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0,),

                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            "Alamat: " + allWordsCapitilize(model.addressBK),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black54, fontSize: 14.0),),
                        ),
                      ],
                    ),
                  ),


                  Flexible(
                    child: Container(),
                  ),
                  Divider(
                    color: Colors.pink,
                    height: 50.0,
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

 allWordsCapitilize (String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}