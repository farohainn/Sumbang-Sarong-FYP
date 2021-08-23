import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/BKRegister.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:sumbang_sarong/Store/home_page.dart';
import 'package:sumbang_sarong/Widgets/customTextField.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Config/config.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register>
{
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _phoneTextEditingController = TextEditingController();
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final GlobalKey <FormState> _formKey = GlobalKey<FormState>();
  //String userImageUrl = "";
  //File _Imagefile;


  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width, _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 10.0,),
            InkWell(
              //onTap: _selectAndPickImage,
              child: CircleAvatar(
                radius: _screenWidth * 0.15,
                backgroundColor: Colors.white,
                //backgroundImage: _Imagefile == null ? null : FileImage(_Imagefile),
                // child: _Imagefile == null
                //     ? Icon(Icons.file_upload, size: _screenWidth * 0.15, color: Colors.grey)
                //     : null,
                child: Icon(Icons.person, size: _screenWidth * 0.15, color: Colors.cyanAccent),
              ),
            ),
            SizedBox(height: 8.0,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Daftar Akaun Sebagai Penyumbang",
                style: TextStyle(fontSize: 35.0, color:  Colors.cyanAccent, fontFamily: "Signatra"),
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
                    controller: _passwordTextEditingController,
                    data: Icons.vpn_key,
                    hintText: "Kata Laluan",
                    isObsecure: true,
                  ),
                ],
              ),
            ),

                  // RaisedButton(
                  //   onPressed: _selectAndPickImage,
                  //   color: Colors.white,
                  //   child: Text("Sila Masukkan Fail Sijil Pendaftaran JPPM", style: TextStyle(color: Colors.pink),),
                  //
                  // ),

            RaisedButton(
              onPressed: () {uploadAndSaveFile();},
              color: Colors.pink,
              child: Text("Daftar Akaun", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(
              height: 30.0,
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
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>BKSignUpPage())),
              icon: (Icon(Icons.people_sharp, color:Colors.pink)),
              label: Text("Daftar Akaun Sebagai Badan Kebajikan", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );

  }

  // Future<void> _selectAndPickImage() async{
  //   //_file = await FilePicker.platform.pickFiles(FileManager)
  //   _Imagefile = await ImagePicker.pickImage(source: ImageSource.gallery);
  // }

  Future<void> uploadAndSaveFile() {

    // if (_Imagefile == null) {
    //   showDialog(
    //       context: context,
    //     builder: (c){
    //         return ErrorAlertDialog(message: "Sila masukkan fail foto Sijil Pendaftaran JPPM di butang muatnaik.",);
    //     }
    //   );
    // } else {}

    _passwordTextEditingController.text.isNotEmpty &&
        _emailTextEditingController.text.isNotEmpty &&
        _nameTextEditingController.text.isNotEmpty &&
        _phoneTextEditingController.text.isNotEmpty

        ? uploadToStorage()

        :displayDialog("Sila lengkapkan maklumat dalam borang..");


  }

  displayDialog(String msg){
    showDialog(
      context: context,
      builder: (c){
        return ErrorAlertDialog(message: msg,);
      }
    );
  }

  uploadToStorage() async{
    showDialog(
      context: context,
      builder: (c){
        return LoadingAlertDialog(message: "Sedang mendaftar, sila tunggu......",);
      }
    );
    _registerUser();

    // String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    //
    // StorageReference storageReference = FirebaseStorage.instance.ref().child(fileName);
    //
    // StorageUploadTask storageUploadTask = storageReference.putFile(_Imagefile);
    //
    // StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    //
    // await taskSnapshot.ref.getDownloadURL().then((urlFile){
    //   userImageUrl = urlFile;
    //
    //   _registerUser();
    // });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async{
    FirebaseUser firebaseUser;

    await _auth.createUserWithEmailAndPassword(
        email: _emailTextEditingController.text.trim(),
        password: _passwordTextEditingController.text.trim(),
    ).then((auth){
      firebaseUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
        builder: (c){
            return ErrorAlertDialog(message: error.message.toString(),);
        }
      );
    });

    if(firebaseUser!=null){
      saveUserToFirestore(firebaseUser).then((value){
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c)=> HomePage());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future <void> saveUserToFirestore(FirebaseUser fUser) async{
    Firestore.instance.collection(Sumbang.collectionUser).document(fUser.uid).setData({
      "uid":fUser.uid,
      "email":fUser.email,
      "name":_nameTextEditingController.text.trim(),
      "phone":_phoneTextEditingController.text.trim(),
      "role": "penyumbang",
      // "url":userImageUrl,
      //Sumbang.userCartList: ["garbageValue"],
    });

    await Sumbang.sharedPreferences.setString("uid", fUser.uid);
    await Sumbang.sharedPreferences.setString(Sumbang.userEmail, fUser.email);
    await Sumbang.sharedPreferences.setString(Sumbang.userName, _nameTextEditingController.text);
    await Sumbang.sharedPreferences.setString(Sumbang.userPhone, _phoneTextEditingController.text);
    // await Sumbang.sharedPreferences.setString(Sumbang.userAvatarUrl, userImageUrl);
    //await Sumbang.sharedPreferences.setStringList(Sumbang.userCartList, ["garbageValue"]);

  }
}

