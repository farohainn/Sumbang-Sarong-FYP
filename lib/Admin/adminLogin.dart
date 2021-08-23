import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Admin/adminPage.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/Widgets/customTextField.dart';

class AdminLogin extends StatelessWidget {
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
      body: AdminLoginScreen(),
    );
  }
}


class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen>
{

  final TextEditingController _IDTextEditingController = TextEditingController();
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
                "Admin",
                style: TextStyle(color: Colors.white, fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _IDTextEditingController,
                    data: Icons.person,
                    hintText: "ID Admin",
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
                _IDTextEditingController.text.isNotEmpty &&
                    _passwordTextEditingController.text.isNotEmpty
                    ? loginAdmin()
                    : showDialog(
                    context: context,
                    builder: (c){
                      return ErrorAlertDialog(message: "Sila masukkan ID dan Kata Laluan.",);
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

  loginAdmin(){

    Firestore.instance.collection("admin").getDocuments().then((snapshot){
      snapshot.documents.forEach((result) {
        if(result.data["ID"] != _IDTextEditingController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("ID anda adalah tidak benar."),));
        }
        else if(result.data["password"] != _passwordTextEditingController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Kata Laluan anda adalah tidak benar."),));
        }
        else{
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Selamat Datang Kepada," + result.data["name"]),));

          setState(() {
            _IDTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });

          Route route = MaterialPageRoute(builder: (c)=> AdminPage());
          Navigator.pushReplacement(context, route);
        }
      });
    });

  }
}
