import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/DialogBox/loadingDialog.dart';
import 'package:sumbang_sarong/Models/adminItem.dart';


import 'adminPage.dart';


class InfoDetails extends StatefulWidget {

  final AdminInfoModel infoModel;
  InfoDetails({this.infoModel});

  @override
  _InfoDetailsState createState() => _InfoDetailsState();
}

class _InfoDetailsState extends State<InfoDetails> with AutomaticKeepAliveClientMixin<InfoDetails> {

  bool get wantKeepAlive => true;
  bool uploading = false;


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
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
            Route route = MaterialPageRoute(builder: (c)=> AdminPage());
            Navigator.pushReplacement(context, route);
          },
          ),
          title: Text(
            "Pengesahan Badan Kebajikan",
          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Image.network(widget.infoModel.urlBK),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: SizedBox(
                          height: 1.0,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allWordsCapitilize(widget.infoModel.nameBK),
                            style: boldTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.infoModel.phoneBK,
                            style: boldTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            allWordsCapitilize(widget.infoModel.addressBK),
                            style: boldTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.infoModel.emailBK,
                            style: boldTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          VerifiedBK();
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [Colors.pink, Colors.cyanAccent],
                              begin: const FractionalOffset(0.0, 0.0,),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 40.00,
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Sah", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  FirebaseAuth _auth = FirebaseAuth.instance;

  void VerifiedBK() async {
    showDialog(
        context: context,
        builder: (c){
          return LoadingAlertDialog(message: "Tahniah, pengguna telah berdaftar!",);
        }
    );

    FirebaseUser firebaseUser;

    await _auth.createUserWithEmailAndPassword(
      email: widget.infoModel.emailBK,
      password: widget.infoModel.passwdBK,
    ).then((auth) {
      auth.user.sendEmailVerification();
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(message: error.message.toString(),);
          }
      );
    });

    if (firebaseUser != null) {
      saveUserToFirestore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => AdminPage());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  int total=0;
  Future <void> saveUserToFirestore(FirebaseUser fUser) async{
      Firestore.instance.collection(Sumbang.collectionUserBK).document(fUser.uid).setData({
        "uidNewBK":fUser.uid,
        "nameNewBK":allWordsCapitilize(widget.infoModel.nameBK),
        "emailNewBK":fUser.email,
        "passwdNewBK":widget.infoModel.passwdBK,
        "phoneNewBK":widget.infoModel.phoneBK,
        "addressNewBK":widget.infoModel.addressBK,
        "urlNewBK":widget.infoModel.urlBK,
        "totalQuantity":total,

      }).whenComplete(() => deleteUser(),);

      await Sumbang.sharedPreferences.setString("uidNewBK", fUser.uid);
      await Sumbang.sharedPreferences.setString(Sumbang.userEmailBK, fUser.email);
      await Sumbang.sharedPreferences.setString(Sumbang.userPasswdBK, widget.infoModel.passwdBK);
      await Sumbang.sharedPreferences.setString(Sumbang.userNameBK, widget.infoModel.nameBK);
      await Sumbang.sharedPreferences.setString(Sumbang.userPhoneBK, widget.infoModel.phoneBK);
      await Sumbang.sharedPreferences.setString(Sumbang.userAddressBK, widget.infoModel.addressBK);
      await Sumbang.sharedPreferences.setString(Sumbang.userAvatarUrlBK, widget.infoModel.urlBK);

  }

  deleteUser(){
    Firestore.instance.collection('permohonan')
        .document(widget.infoModel.uidBK)
        .delete();
  }
}


const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

allWordsCapitilize (String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}
