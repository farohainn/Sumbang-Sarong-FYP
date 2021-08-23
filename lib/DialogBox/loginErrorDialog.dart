import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Authentication/authenication.dart';
import 'package:sumbang_sarong/Config/config.dart';

class LoginErrorAlertDialog extends StatelessWidget
{
  final String message;
  const LoginErrorAlertDialog({Key key, this.message}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: <Widget>[
        RaisedButton(onPressed: ()
        {
          Sumbang.auth.signOut().then((c){
            Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
            Navigator.pushReplacement(context, route);
          });
        },
          color: Colors.red,
          child: Center(
            child: Text("Daftar Akaun Sekarang"),
          ),
        )
      ],
    );
  }
}
