import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/loginErrorDialog.dart';
import 'package:sumbang_sarong/Role_Authorization/userManagement.dart';
import 'package:sumbang_sarong/Store/clothCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sumbang_sarong/Widgets/customAppBar.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox2.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {

  final Choose value;
  StoreHome({Key key, this.value}) : super(key: key);



  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {

  @override
  Widget build(BuildContext context) {
    width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true, delegate: SearchBoxDelegate(),),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection(Sumbang.collectionUserBK)
                  .document(widget.value.uid)
                  .collection(Sumbang.collectionRecordBK)
                  .where("clothCategoryByBK", isEqualTo: widget.value.cloth)
                  .limit(15)
                  .orderBy("recordTime", descending: true)
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                      child: Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Maaf tiada rekod keperluan sumbangan.", style: TextStyle(color: Colors.pink, fontSize: 24.0, fontWeight: FontWeight.bold),),
                      ),),)
                    : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    ItemModel model = ItemModel.fromJson(
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


  Widget sourceInfo(ItemModel model, BuildContext context,
      {Color background}) {
    return InkWell(
      onTap: () {
        // model.iconSelected = widget.value.cloth;
        // model.nameRecordBy = widget.value.name;
        // FirebaseAuth.instance.currentUser().then((user) {
        //   print(user.isAnonymous);
        //   if(user.isAnonymous){
        //     print(user.uid);
        //     displayDialog("Maaf, sila berdaftar sebagai Penyumbang untuk meneruskan sumbangan.");
        //   }
        //   else{
        //     print(user.isEmailVerified);
        //     UserManagement().authorizeAccessPenyumbang(model, context);
        //   }
        // });

      },
      splashColor: Colors.pink,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          height: 190.0,
          width: width,
          child: Row(
            children: [
              widget.value.cloth =="Baju Kurung"
              ?
              Image.asset(
                "images/bajukurung.png", width: 120.0, height: 120.0,)
              :
              widget.value.cloth =="Baju Lengan Panjang"
              ?
              Image.asset(
                "images/shirt.png", width: 120.0, height: 120.0,)
              :
              widget.value.cloth =="Seluar."
              ?
              Image.asset(
                "images/seluar.png", width: 120.0, height: 120.0,)
              :
              widget.value.cloth =="Baju Melayu"
              ?
              Image.asset(
                "images/bajumelayu.png", width: 120.0, height: 120.0,)
              :
              widget.value.cloth =="Baju Lengan Pendek"
              ?
              Image.asset(
                "images/shirtpendek.png", width: 120.0, height: 120.0,)
              :
              Image.asset(
                "images/seluargirl.png", width: 120.0, height: 120.0,),

              //SizedBox(width: 4.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0,),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                                child: Text(
                                  allWordsCapitilize(widget.value.name),
                                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),),
                              ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Kategori Pakaian: ", style: TextStyle(
                              color: Colors.black54, fontSize: 14.0),),
                          Text(model.clothCategoryByBK, style: TextStyle(
                              color: Colors.black54, fontSize: 14.0),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Jantina Pakaian: ", style: TextStyle(
                              color: Colors.black54, fontSize: 14.0),),
                          Text(model.genderCategoryByBK, style: TextStyle(
                              color: Colors.black54, fontSize: 14.0),),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0,),

                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Kuantiti yang diperlukan: ",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 14.0),),
                          Text(
                            (model.quantityByBK).toString(),
                            style: TextStyle(
                                color: Colors.black54, fontSize: 14.0),),
                        ],
                      ),
                    ),

                    SizedBox(height: 5.0,),

                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Kuantiti sumbangan belum diterima: ",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 14.0),),
                          Text(
                            (model.quantityPending).toString(),
                            style: TextStyle(
                                color: Colors.black54, fontSize: 14.0),),
                        ],
                      ),
                    ),

                    Flexible(
                      child: Container(),
                    ),

                    Divider(
                      height: 3.0,
                      color: Colors.pink,
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


allWordsCapitilize (String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}
Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}

