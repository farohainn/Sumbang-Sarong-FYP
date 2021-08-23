import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sumbang_sarong/Models/charityHubModel.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:sumbang_sarong/Store/clothCategory.dart';

class Charity {
  final String name,uid;

  const Charity(
      {
        this.name,
        this.uid,
      }
      );
}

class ChooseGender extends StatefulWidget {

  final CharityModel charityModel;
  ChooseGender({this.charityModel});

  @override
  _ChooseGenderState createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
            Route route = MaterialPageRoute(builder: (c)=> CharityHubList());
            Navigator.pushReplacement(context, route);
          },
          ),
          title: Text(
            "Jantina Pemakai",
            style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sila Pilih Jantina Pemakai",
                  style: TextStyle(fontSize: 16.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)),
                    child: Text(
                      "Lelaki",
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),


                    color: Colors.cyanAccent,
                    onPressed: () {
                      //Fluttertoast.showToast(msg: widget.charityModel.nameNewBK);
                      var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new ClothCategoryBoy(
                            charity: Charity(
                                name: widget.charityModel.nameNewBK,
                                uid: widget.charityModel.uidNewBK
                            )
                        ),
                      );
                      Navigator.of(context).push(route);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)),
                    child: Text(
                      "Perempuan",
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    color: Colors.cyanAccent,
                    onPressed: () {
                      var route = new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new ClothCategoryGirl(
                            charity: Charity(
                              name: widget.charityModel.nameNewBK,
                              uid: widget.charityModel.uidNewBK
                            )
                        ),
                      );
                      Navigator.of(context).push(route);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
