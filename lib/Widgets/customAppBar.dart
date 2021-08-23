import 'package:firebase_auth/firebase_auth.dart';
import 'package:sumbang_sarong/Appointments/myAppointments.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/DialogBox/loginErrorDialog.dart';
import 'package:sumbang_sarong/Role_Authorization/userManagement.dart';


class MyAppBar extends StatelessWidget with PreferredSizeWidget
{
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
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
      centerTitle: true,
      title: Text(
        "Sumbang Sarong",
        style: TextStyle(fontSize: 55.0, color:  Colors.white, fontFamily: "Signatra"),
      ),
      bottom: bottom,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.airport_shuttle, color: Colors.pink,),
              onPressed: (){
                FirebaseAuth.instance.currentUser().then((user) {
                  print(user.isAnonymous);
                  if(user.isAnonymous){
                    print(user.uid);
                    showDialog(
                        context: context,
                        builder: (c) {
                          return LoginErrorAlertDialog(message: "Maaf, sila berdaftar sebagai Penyumbang untuk meneruskan sumbangan.");
                        }
                    );
                  }
                  else{
                    print(user.isEmailVerified);
                    UserManagement().authorizeAccessTemujanjiPenyumbang(context);
                  }
                });
              },
            ),
          ],
        ),
      ],
    );

  }

  Size get preferredSize => bottom==null?Size(56,AppBar().preferredSize.height):Size(56, 80+AppBar().preferredSize.height);
}
