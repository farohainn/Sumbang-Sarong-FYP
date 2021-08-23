import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sumbang_sarong/Admin/adminLogin.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/bkLogin.dart';
import 'package:sumbang_sarong/Role_Authorization/annon.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:sumbang_sarong/Store/home_page.dart';
import 'package:sumbang_sarong/Widgets/customTextField.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Config/config.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
{

  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;

    AuthServices auth = AuthServices();

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/login.png",
                height: 240.0,
                width: 240.0,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
              child: Text(
                "Daftar Masuk ke akaun anda.",
                style: TextStyle(color: Colors.white),
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
            RaisedButton(
              onPressed: () {
                _emailTextEditingController.text.isNotEmpty &&
                    _passwordTextEditingController.text.isNotEmpty
                    ? loginUser()
                    : showDialog(
                          context: context,
                          builder: (c){
                            return ErrorAlertDialog(message: "Sila masukkan Emel dan Kata Laluan.",);
                          }
                      );
              },
              color: Colors.pink,
              child: Text("Daftar Masuk", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton(
              onPressed: () async{
                final result = await auth.signInAnon();
                if(result != null){
                  Route route = MaterialPageRoute(builder: (c) => HomePage());
                  Navigator.pushReplacement(context, route);
                } else{
                  print("This error for anon sign in");
                }
              },
              child: Text("Langkau Dahulu", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth *0.8,
              color: Colors.pink,
            ),
            SizedBox(
              height: 15.0,
            ),
            FlatButton.icon(
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>BKLogin())),
              icon: (Icon(Icons.people_sharp, color:Colors.pink)),
              label: Text("Saya merupakan Badan Kebajikan", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 15.0,
            ),
            FlatButton.icon(
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin())),
              icon: (Icon(Icons.person, color:Colors.pink)),
              label: Text("Saya merupakan Admin", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }


  FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async{
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
      firebaseUser = authUser.user;
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
        Route route = MaterialPageRoute(builder: (c)=> HomePage());
        Navigator.pushReplacement(context, route);
      });

    }
  }

  Future readData (FirebaseUser fUser) async{
    Firestore.instance.collection(Sumbang.collectionUser).document(fUser.uid).get().then((dataSnapshot) async {

      await Sumbang.sharedPreferences.setString("uid", dataSnapshot.data[Sumbang.userUID]);

      await Sumbang.sharedPreferences.setString(Sumbang.userEmail, dataSnapshot.data[Sumbang.userEmail]);

      await Sumbang.sharedPreferences.setString(Sumbang.userName, dataSnapshot.data[Sumbang.userName]);

      await Sumbang.sharedPreferences.setString(Sumbang.userPhone, dataSnapshot.data[Sumbang.userPhone]);

    });
    
  }
}
