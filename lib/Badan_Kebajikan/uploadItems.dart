import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/SaveItem.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';

int quantityPending = 0;

class UploadItems extends StatefulWidget {

  @override
  _UploadItemsState createState() => _UploadItemsState();
}
class _UploadItemsState extends State<UploadItems> {

  TextEditingController quantityTextEditingController = new TextEditingController();

  // Default Drop Down Item.
  String dropdownValue1 = 'Sila Pilih Jantina Pakaian';
  String dropdownValue2 = 'Sila Pilih Kategori Pakaian';
  String dropdownValue3 = 'Sila Pilih Kategori Pakaian';

  // To show Selected Item in Text.
  // String holder1 = '';
  // String holder2 = '';
  // String holder3 = '';

  List <String> genderCategory = [
    'Sila Pilih Jantina Pakaian',
    'Lelaki',
    'Perempuan',
  ];
  List <String> clothCategoryGirl = [
    'Sila Pilih Kategori Pakaian',
    'Seluar',
    'Baju Kurung',
    'Baju Lengan Panjang',
  ];
  List <String> clothCategoryBoy = [
    'Sila Pilih Kategori Pakaian',
    'Seluar.',
    'Baju Melayu',
    'Baju Lengan Pendek',
  ];

  // void getDropDownItem() {
  //   setState(() {
  //     holder1 = dropdownValue1;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SaveItem())),
        ),
        title: Text("Rekod Baharu", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),),
        actions: [
          FlatButton(
            onPressed: (){saveItemInfo();},
            child: Text("Tambah", style: TextStyle(color: Colors.pink, fontSize: 16.0, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Center(
              child: CircleAvatar(
                radius: _screenWidth * 0.15,
                backgroundColor: Colors.black12,
                child: Icon(Icons.assignment_sharp, size: _screenWidth * 0.15, color: Colors.cyanAccent),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0, right: 50.0),
            child: DropdownButton<String>(
              value: dropdownValue1,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.pink, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.cyan,
              ),
              onChanged: (String data) {
                setState(() {
                  dropdownValue1 = data;
                });
              },
            items: genderCategory.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),

            ),
          ),

          dropdownValue1 == genderCategory[1]
          ?
          Container(
            margin: EdgeInsets.only(top: 20.0, right: 50.0),
            child: DropdownButton<String>(
              value: dropdownValue3,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.pink, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.cyan,
              ),
              onChanged: (String data) {
                setState(() {
                  dropdownValue3 = data;
                });
              },
            items: clothCategoryBoy.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),

            ),
          )
          :
          Container(
            margin: EdgeInsets.only(top: 20.0, right: 50.0),
            child: DropdownButton<String>(
              value: dropdownValue2,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 25,
              style: TextStyle(color: Colors.pink, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.cyan,
              ),
              onChanged: (String data) {
                setState(() {
                  dropdownValue2 = data;
                });
              },
            items: clothCategoryGirl.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),

            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20.0, left:50.0, right: 80.0 ),
            child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.pink, fontSize: 18),
                controller: quantityTextEditingController,
                decoration: InputDecoration(
                  hintText: "Kuantiti diperlukan",
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 18),
                  border: OutlineInputBorder(),
                ),
              ),
          ),


        ],
      ),
    );
  }



  saveItemInfo() {

    quantityTextEditingController.text.isEmpty &&
        dropdownValue1 == genderCategory[0] &&
        dropdownValue2 == clothCategoryGirl[0] &&
        dropdownValue3 == clothCategoryBoy[0]

        ? displayDialog("Sila Lengkapkan Borang Rekod Keperluan Sumbangan.")
        : uploadRecord();

    }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(message: msg,);
        }
    );
  }

  uploadRecord() async{

    int total=0;
    Sumbang.firestore.collection(Sumbang.collectionUserBK)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUIDBK))
        .get().then((doc){
      total= doc.data['totalQuantity'];

      Sumbang.firestore.collection(Sumbang.collectionUserBK)
          .document(Sumbang.sharedPreferences.getString(Sumbang.userUIDBK))
          .updateData({
        "totalQuantity": int.parse(quantityTextEditingController.text) + total
      });
    });

    dropdownValue1 == genderCategory[1]
    ?
    writeRecordDetailsForBadanKebajikan({
      "recordBy": Sumbang.sharedPreferences.getString(Sumbang.userUIDBK),
       "genderCategoryByBK" : dropdownValue1,
      "clothCategoryByBK" : dropdownValue3,
      "quantityByBK": int.parse(quantityTextEditingController.text),
      "quantityPending": quantityPending,
      "recordTime" : DateTime
        .now().millisecondsSinceEpoch.toString(),

    }).whenComplete(() =>{
      completeDonate()
    })
    :
    writeRecordDetailsForBadanKebajikan({
    "recordBy": Sumbang.sharedPreferences.getString(Sumbang.userUIDBK),
      "genderCategoryByBK" : dropdownValue1,
      "clothCategoryByBK" : dropdownValue2,
      "quantityByBK" : int.parse(quantityTextEditingController.text),
      "quantityPending": quantityPending,
      "recordTime" : DateTime
        .now().millisecondsSinceEpoch.toString(),

    }).whenComplete(() =>{
      completeDonate()
    });

  }

  completeDonate(){

    Fluttertoast.showToast(msg: "Rekod Baharu Berjaya!");

    Route route = MaterialPageRoute(builder: (c) => SaveItem());
    Navigator.pushReplacement(context, route);

    setState(() {
        quantityTextEditingController.clear();
      });
  }

  Future writeRecordDetailsForBadanKebajikan(Map<String, dynamic> data) async{
    await Sumbang.firestore.collection(Sumbang.collectionUserBK)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUIDBK))
        .collection(Sumbang.collectionRecordBK)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUIDBK) + data["recordTime"])
        .setData(data);

    await Sumbang.firestore.collection(Sumbang.collectionDetailRecordBK)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUIDBK) + data["recordTime"])
        .setData(data);
  }

}