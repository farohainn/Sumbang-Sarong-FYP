import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:sumbang_sarong/Store/product_details.dart';
import 'package:sumbang_sarong/Models/item.dart';
import 'package:flutter/material.dart';

int currentQuantity = 0;

class Detail {
  final String iconSelected,nameRecordBy,recordBy,genderCategoryByBK,recordTime,clothCategoryByBK;
  final int quantityPending;

  const Detail(
      {
        this.iconSelected,
        this.nameRecordBy,
        this.recordBy,
        this.genderCategoryByBK,
        this.recordTime,
        this.clothCategoryByBK,
        this.quantityPending,
      }
      );
}

class ProductPage extends StatefulWidget {

  final ItemModel itemModel;
  ProductPage({this.itemModel});

  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage> with AutomaticKeepAliveClientMixin<ProductPage> {

  bool get wantKeepAlive => true;


  TextEditingController quantityTextEditingController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return SafeArea(
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
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white,), onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CharityHubList())),
          ),
          title: Text("Sumbangan", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child:
                        widget.itemModel.iconSelected =="Baju Kurung"
                            ?
                        Image.asset(
                          "images/bajukurung.png", width: 140.0, height: 140.0,)
                            :
                        widget.itemModel.iconSelected =="Baju Lengan Panjang"
                            ?
                        Image.asset(
                          "images/shirt.png", width: 140.0, height: 140.0,)
                            :
                        widget.itemModel.iconSelected =="Seluar."
                            ?
                        Image.asset(
                          "images/seluar.png", width: 140.0, height: 140.0,)
                            :
                        widget.itemModel.iconSelected =="Baju Melayu"
                            ?
                        Image.asset(
                          "images/bajumelayu.png", width: 140.0, height: 140.0,)
                            :
                        widget.itemModel.iconSelected =="Baju Lengan Pendek"
                            ?
                        Image.asset(
                          "images/shirtpendek.png", width: 140.0, height: 140.0,)
                            :
                        Image.asset(
                          "images/seluargirl.png", width: 140.0, height: 140.0,),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: SizedBox(
                          height: 1.0,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allWordsCapitilize(widget.itemModel.nameRecordBy),
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Kategori pakaian: " +
                            widget.itemModel.clothCategoryByBK,
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Jantina pakaian: " +
                            widget.itemModel.genderCategoryByBK,
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Kuantiti keperluan sumbangan: " +
                                (widget.itemModel.quantityByBK).toString(),
                            style: boldTextStyle,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.pink, fontSize: 18),
                            controller: quantityTextEditingController,
                            decoration: InputDecoration(
                              hintText: "Kuantiti yang hendak disumbangkan",
                              hintStyle: TextStyle(color: Colors.grey[500], fontSize: 18),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Divider(color: Colors.pink,),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          //checkItemInCart(widget.itemModel.clothCategory, context);
                          saveAppointmentInfo();
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [Colors.pink, Colors.cyanAccent],
                              begin: const FractionalOffset(0.0, 0.0,),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width - 40.00,
                          height: 50.0,
                          child: Center(
                            child: Text("Sumbang",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  saveAppointmentInfo() {

    int currentQuantity=0;
    Firestore.instance.collection(Sumbang.collectionUserBK)
        .document(widget.itemModel.recordBy)
        .collection(Sumbang.collectionRecordBK)
        .where("recordTime", isEqualTo: widget.itemModel.recordTime)
        .getDocuments()
        .then((docs) {

      currentQuantity = ((docs.documents[0].data['quantityByBK']) - (docs.documents[0].data['quantityPending']));

      if(int.parse(quantityTextEditingController.text) > docs.documents[0].data['quantityByBK']){
        displayDialog("Maaf, kuantiti melebihi keperluan sumbangan.");
      }
      else if( currentQuantity < int.parse(quantityTextEditingController.text)){
        displayDialog("Maaf, kuantiti melebihi sumbangan belum diterima.");
      }
      else if(quantityTextEditingController.text.isEmpty ){
        displayDialog("Sila isi kuantiti yang hendak disumbangkan");
      }
      else{
        Fluttertoast.showToast(msg: "Kemudian, sila isi masa dan tarikh untuk sesi janji temu.");

        var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
          new ProductDetails(
              detail: Detail(
                  iconSelected: widget.itemModel.iconSelected,
                  nameRecordBy: widget.itemModel.nameRecordBy,
                  recordBy: widget.itemModel.recordBy,
                  genderCategoryByBK: widget.itemModel.genderCategoryByBK,
                  recordTime: widget.itemModel.recordTime,
                  clothCategoryByBK: widget.itemModel.clothCategoryByBK,
                  quantityPending: int.parse(quantityTextEditingController.text)
              )
          ),
        );
        Navigator.of(context).push(route);

        uploadInfoDonate();
      }
    });


  }

  uploadInfoDonate() async{

    writeAppointDetailsForInfoDonate({
      "donateBy": Sumbang.sharedPreferences.getString(Sumbang.userUID),
      Sumbang.donationRecordByBK: widget.itemModel.recordBy,
      Sumbang.donationRecordTimeBK: widget.itemModel.recordTime,
      Sumbang.clothCategory : widget.itemModel.clothCategoryByBK,
      Sumbang.genderCategory: widget.itemModel.genderCategoryByBK,
      "quantityDonate": int.parse(quantityTextEditingController.text),
      "donateRecord": DateTime
          .now()
          .millisecondsSinceEpoch
          .toString(),

    });

  }

  Future writeAppointDetailsForInfoDonate (Map<String, dynamic> data) async{
    await Sumbang.firestore
        .collection(Sumbang.infoDonate)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUID) + data['donateRecord'])
        .setData(data);
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(message: msg,);
        }
    );
  }

}

allWordsCapitilize (String str) {
  return str.toLowerCase().split(' ').map((word) {
    String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
    return word[0].toUpperCase() + leftText;
  }).join(' ');
}
const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
