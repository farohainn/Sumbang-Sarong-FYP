import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sumbang_sarong/Authentication/authenication.dart';
import 'package:sumbang_sarong/DialogBox/loadingDialog.dart';
import 'package:sumbang_sarong/Widgets/customTextField.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';

class BKSignUpPage extends StatelessWidget {
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
        title: Text(
          "Sumbang Sarong",
          style: TextStyle(
              fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      body: BKSignUpScreen(),
    );
  }
}

class BKSignUpScreen extends StatefulWidget {
  @override
  _BKSignUpScreenState createState() => _BKSignUpScreenState();
}

class _BKSignUpScreenState extends State<BKSignUpScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  final TextEditingController _addressTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  String ID = DateTime.now().millisecondsSinceEpoch.toString();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _Imagefile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              //onTap: _selectAndPickImage,
              child: CircleAvatar(
                radius: _screenWidth * 0.15,
                backgroundColor: Colors.white,
                //backgroundImage: _Imagefile == null ? null : FileImage(_Imagefile),
                // child: _Imagefile == null
                //     ? Icon(Icons.file_upload, size: _screenWidth * 0.15, color: Colors.grey)
                //     : null,
                child: Icon(Icons.people_sharp,
                    size: _screenWidth * 0.15, color: Colors.cyanAccent),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Daftar Akaun Sebagai Badan Kebajikan",
                    style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontFamily: "Signatra"),
                  ),
                  CustomTextField(
                    controller: _nameTextEditingController,
                    data: Icons.person,
                    hintText: "Nama Penuh",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _emailTextEditingController,
                    data: Icons.email,
                    hintText: "Emel",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _phoneTextEditingController,
                    data: Icons.phone_android,
                    hintText: "Nombor Telefon",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _addressTextEditingController,
                    data: Icons.location_pin,
                    hintText: "Alamat Rumah Badan Kebajikan",
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
            RaisedButton.icon(
              onPressed: _selectAndPickImage,
              icon: Icon(
                Icons.upload_sharp,
                color: Colors.pink,
              ),
              label: Text(
                "Sila Muatnaik Foto Sijil Pendaftaran JPPM",
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              onPressed: () {
                uploadAndSaveFile();
              },
              color: Colors.pink,
              child: Text(
                "Daftar Akaun",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: _screenWidth * 0.8,
              child: Text(
                "Setiap rumah kebajikan yang hendak mendaftar di dalam aplikasi perlu mendapatkan kelulusan daripada Admin. Setelah itu, anda akan mendapat emel pemberitahuan pengesahan.",
                style: TextStyle(color: Colors.black, fontSize: 12.0),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.pink,
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectAndPickImage() async {
    //_file = await FilePicker.platform.pickFiles(FileManager)
    _Imagefile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadAndSaveFile() {
    if (_Imagefile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message:
                  "Sila masukkan fail foto Sijil Pendaftaran JPPM di butang muatnaik.",
            );
          });
    } else {
      _passwordTextEditingController.text.isNotEmpty &&
              _emailTextEditingController.text.isNotEmpty &&
              _nameTextEditingController.text.isNotEmpty &&
              _phoneTextEditingController.text.isNotEmpty &&
              _addressTextEditingController.text.isNotEmpty
          ? uploadToStorage()
          : displayDialog("Sila lengkapkan maklumat dalam borang..");
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message:
                "Permohonan sedang diproses! Sila tunggu emel daripada kami.",
          );
        });

    String fileName = _nameTextEditingController.text.trim() + "00";

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(fileName);

    StorageUploadTask storageUploadTask = storageReference.putFile(_Imagefile);

    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

    await taskSnapshot.ref.getDownloadURL().then((urlFile) {
      userImageUrl = urlFile;

      _registerUser();
    });
  }

  void _registerUser() async {
    final registerRef = Firestore.instance.collection("permohonan");
    registerRef.document(ID).setData({
      "uidBK": ID,
      "emailBK": _emailTextEditingController.text,
      "nameBK": _nameTextEditingController.text.trim(),
      "passwdBK": _passwordTextEditingController.text.trim(),
      "phoneBK": _phoneTextEditingController.text.trim(),
      "addressBK": _addressTextEditingController.text,
      "urlBK": userImageUrl,
      "publishedDate": DateTime.now(),
    });

    if (registerRef != null) {
      Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
      Navigator.pushReplacement(context, route);
    }

    setState(() {
      _emailTextEditingController.clear();
      _nameTextEditingController.clear();
      _phoneTextEditingController.clear();
      _passwordTextEditingController.clear();
      _addressTextEditingController.clear();
    });
  }
}
