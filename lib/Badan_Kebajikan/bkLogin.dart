import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/SaveItem.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/DialogBox/loadingDialog.dart';
import 'package:sumbang_sarong/DialogBox/loginErrorDialog.dart';
import 'package:sumbang_sarong/Widgets/customTextField.dart';




class BKLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.pink, Colors.cyanAccent],
              begin: const FractionalOffset(0.0, 0.0,),
              end: const FractionalOffset(1.0, 0.0),
              stops:[0.0,1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(
          "Sumbang Sarong",
          style: TextStyle(fontSize: 55.0, color:  Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle:  true,
      ),
      body: BKLoginScreen(),
    );
  }
}


class BKLoginScreen extends StatefulWidget {
  @override
  _BKLoginScreenState createState() => _BKLoginScreenState();
}

class _BKLoginScreenState extends State<BKLoginScreen>
{

  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.pink, Colors.cyanAccent],
            begin: const FractionalOffset(0.0, 0.0,),
            end: const FractionalOffset(1.0, 0.0),
            stops:[0.0,1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/admin.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Badan Kebajikan",
                style: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Emel",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.vpn_key,
                    hintText: "Kata Laluan",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            RaisedButton(
              onPressed: () {
                _emailTextEditingController.text.isNotEmpty &&
                    _passwordTextEditingController.text.isNotEmpty
                    ? loginBK()
                    : showDialog(
                    context: context,
                    builder: (c){
                      return ErrorAlertDialog(message: "Sila masukkan emel dan Kata Laluan.",);
                    }
                );
              },
              color: Colors.pink,
              child: Text("Daftar Masuk", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 50.0,
            ),

            SizedBox(
              height: 120.0,
            ),

          ],
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void loginBK() async{
    showDialog(
        context: context,
        builder: (c){
          return LoadingAlertDialog(message: "Sedang mengesahkan, sila tunggu.....",);
        }
    );

    FirebaseUser firebaseUser;
    await _auth.signInWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    ).then((authUser) {
      if(authUser.user.isEmailVerified) {
        firebaseUser = authUser.user;
      }
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c){
            return ErrorAlertDialog(message: error.message.toString(),);
          }
      );
    });
    if(firebaseUser != null){

      readData(firebaseUser).then((s){

        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c)=> SaveItem());
        Navigator.pushReplacement(context, route);
      });
    }
  }
  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return LoginErrorAlertDialog(message: msg,);
        }
    );
  }

  Future readData (FirebaseUser fUser) async{
    Firestore.instance.collection(Sumbang.collectionUserBK).document(fUser.uid).get().then((dataSnapshot) async {

      await Sumbang.sharedPreferences.setString("uidNewBK", dataSnapshot.data[Sumbang.userUIDBK]);

      await Sumbang.sharedPreferences.setString(Sumbang.userEmailBK, dataSnapshot.data[Sumbang.userEmailBK]);

      await Sumbang.sharedPreferences.setString(Sumbang.userNameBK, dataSnapshot.data[Sumbang.userNameBK]);

      await Sumbang.sharedPreferences.setString(Sumbang.userPhoneBK, dataSnapshot.data[Sumbang.userPhoneBK]);

      await Sumbang.sharedPreferences.setString(Sumbang.userAddressBK, dataSnapshot.data[Sumbang.userAddressBK]);

      await Sumbang.sharedPreferences.setString(Sumbang.userAvatarUrlBK, dataSnapshot.data[Sumbang.userAvatarUrlBK]);

    });

  }
}
