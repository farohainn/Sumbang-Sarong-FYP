
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/uploadItems.dart';
import 'package:sumbang_sarong/Config/config.dart';


import '../main.dart';
import 'bkAppointment.dart';

class SaveItem extends StatefulWidget {
  SaveItem({Key key}) : super(key: key);
  @override
  _SaveItemState createState() => _SaveItemState();
}

class _SaveItemState extends State<SaveItem>
{

  TextEditingController quantityTextEditingController = new TextEditingController();
  TextEditingController categoryGenderTextEditingController = new TextEditingController();
  TextEditingController categoryClothTextEditingController = new TextEditingController();
  String donationRecordID = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
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
            Icons.airport_shuttle,
            color: Colors.white,
          ),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => BKAppointment())),
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
      body: getBKHomeScreenBody(),
    );
  }


  getBKHomeScreenBody() {
    return Container(
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.app_registration,
              color: Colors.white,
              size: 200.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0)),
                child: Text(
                  "Rekod Keperluan Sumbangan",
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
                color: Colors.cyanAccent,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadItems())),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

