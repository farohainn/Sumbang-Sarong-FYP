import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sumbang_sarong/Maps/DataHandler/appData.dart';
import 'package:sumbang_sarong/Role_Authorization/userManagement.dart';
import 'Authentication/authenication.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'Maps/DataHandler/appData.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Sumbang.auth = FirebaseAuth.instance;
  Sumbang.sharedPreferences = await SharedPreferences.getInstance();
  Sumbang.firestore = Firestore.instance;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) =>AppData()),
      ],
      child: MaterialApp(
              title: 'Sumbang Sarong',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.black,
              ),
              home: UserManagement().handleAuth(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    displaySplash();
  }

  displaySplash(){
    Timer(Duration(seconds: 5), () async{

      Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
      Navigator.pushReplacement(context, route);

      // if(await Sumbang.auth.currentUser() !=null){
      //   Route route = MaterialPageRoute(builder: (_) => StoreHome());
      //   Navigator.pushReplacement(context, route);
      // }else{
      //   Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
      //   Navigator.pushReplacement(context, route);
      // }

    });
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: new BoxDecoration(
          gradient:  new LinearGradient(
            colors: [Colors.pink, Colors.cyanAccent],
            begin: const FractionalOffset(0.0, 0.0,),
            end: const FractionalOffset(1.0, 0.0),
            stops:[0.0,1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/welcome.png"), //tukar nanti
              SizedBox(height: 20.0,),
              Text(
                  "Aplikasi Pertama Khusus Untuk Sumbangan Pakaian Terpakai",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
