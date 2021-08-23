import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';


class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
        child: Scaffold(
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
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.lock, color: Colors.white,),
                  text:  "Daftar Masuk",
                ),
                Tab(
                  icon: Icon(Icons.perm_contact_calendar, color: Colors.white,),
                  text:  "Daftar Akaun",
                ),
              ],
              indicatorColor: Colors.white38,
              indicatorWeight: 5.0,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.pink, Colors.cyanAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: TabBarView(
              children: [
                Login(),
                Register(),
              ],
            ),
          ),
        ),
    );
  }
}
