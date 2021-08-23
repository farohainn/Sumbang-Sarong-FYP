import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/Models/charityHubModel.dart';
import 'package:sumbang_sarong/Models/item.dart';
import 'package:sumbang_sarong/Store/infoDonation.dart';
import 'package:sumbang_sarong/Widgets/loadingWidget.dart';
import 'package:sumbang_sarong/test/sheesh.dart';

class ToDonate extends StatefulWidget {
  ToDonate({Key key, this.charity, this.model}) : super(key: key);

  final CharityModel charity;
  final ItemModel model;

  @override
  _ToDonateState createState() => _ToDonateState();
}

class _ToDonateState extends State<ToDonate> {
  TextEditingController quantityTextEditingController = TextEditingController();

  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50 * (MediaQuery.of(context).size.height / 100),
                decoration: BoxDecoration(color: Colors.pinkAccent[700]),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 30.0,
                          color: Colors.white,
                        )),
                    Spacer(),
                  ],
                ),
              ),
              widget.model.clothCategoryByBK == "Baju Melayu"
                  ? Positioned(
                      top: 130.0,
                      left: 100.0,
                      child: Image.asset(
                        "images/baju1.png",
                        height: 50 * (MediaQuery.of(context).size.width / 100),
                        width: 50 * (MediaQuery.of(context).size.width / 100),
                      ),
                    )
                  : widget.model.clothCategoryByBK == "Seluar."
                      ? Positioned(
                          top: 130.0,
                          left: 100.0,
                          child: Image.asset(
                            "images/baju2.png",
                            height:
                                50 * (MediaQuery.of(context).size.width / 100),
                            width:
                                50 * (MediaQuery.of(context).size.width / 100),
                          ),
                        )
                      : widget.model.clothCategoryByBK == "Baju Lengan Pendek"
                          ? Positioned(
                              top: 130.0,
                              left: 100.0,
                              child: Image.asset(
                                "images/baju3.png",
                                height: 50 *
                                    (MediaQuery.of(context).size.width / 100),
                                width: 50 *
                                    (MediaQuery.of(context).size.width / 100),
                              ),
                            )
                          : widget.model.clothCategoryByBK == "Baju Kurung"
                              ? Positioned(
                                  top: 130.0,
                                  left: 100.0,
                                  child: Image.asset(
                                    "images/baju4.png",
                                    height: 50 *
                                        (MediaQuery.of(context).size.width /
                                            100),
                                    width: 50 *
                                        (MediaQuery.of(context).size.width /
                                            100),
                                  ),
                                )
                              : widget.model.clothCategoryByBK == "Seluar"
                                  ? Positioned(
                                      top: 130.0,
                                      left: 100.0,
                                      child: Image.asset(
                                        "images/baju5.png",
                                        height: 50 *
                                            (MediaQuery.of(context).size.width /
                                                100),
                                        width: 50 *
                                            (MediaQuery.of(context).size.width /
                                                100),
                                      ),
                                    )
                                  : widget.model.clothCategoryByBK ==
                                          "Baju Lengan Panjang"
                                      ? Positioned(
                                          top: 130.0,
                                          left: 100.0,
                                          child: Image.asset(
                                            "images/baju6.png",
                                            height: 50 *
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    100),
                                            width: 50 *
                                                (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    100),
                                          ),
                                        )
                                      : circularProgress(),
              Positioned(
                top: 45 * (MediaQuery.of(context).size.height / 100),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55 * (MediaQuery.of(context).size.height / 100),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 40.0, bottom: 20.0),
                        child: Text(
                          widget.model.clothCategoryByBK,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 3 *
                                  (MediaQuery.of(context).size.height / 100),
                              fontFamily: 'OpenSans'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          (widget.model.quantityByBK - widget.model.quantityPending).toString() +
                              " helai diperlukan",
                          style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 2.5 *
                                  (MediaQuery.of(context).size.height / 100),
                              fontFamily: 'OpenSans'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          widget.model.quantityPending.toString() +
                              " helai belum diterima",
                          style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 2.5 *
                                  (MediaQuery.of(context).size.height / 100),
                              fontFamily: 'OpenSans'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                        child: Text(
                          "Penyumbang haruslah membuat sumbangan tidak melebihi kuantiti belum diterima. Kuantiti belum diterima bermaksud penyumbang telah menempah untuk menghantar sumbangan tetapi masih belum diterima oleh rumah kebajikan.",
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.2,
                              fontWeight: FontWeight.bold,
                              fontSize: 2 *
                                  (MediaQuery.of(context).size.height / 100),
                              fontFamily: 'OpenSans'),
                        ),
                      ),
                      SizedBox(height: 1.2 * (MediaQuery.of(context).size.height/100),),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 73.0),
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.airport_shuttle),
                                SizedBox(width: 3 * (MediaQuery.of(context).size.width/100),),
                                Text("Tempah Janji Temu Bagi Proses Penghantaran", style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.2,
                                    fontSize: 1.8 * (MediaQuery.of(context).size.height/100),
                                    fontFamily: 'OpenSans'
                                ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 610.0),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      buildOutlineButton(
                        icon: Icons.remove,
                        press: () {
                          if (numOfItems > 1) {
                            setState(() {
                              numOfItems--;
                            });
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0 / 2),
                        child: Text(
                          // if our item is less  then 10 then  it shows 01 02 like that
                          numOfItems.toString().padLeft(2, "0"),
                          style: TextStyle(fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      buildOutlineButton(
                          icon: Icons.add,
                          press: () {
                            setState(() {
                              numOfItems++;
                            });
                          }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 700),
                child: Center(
                  child: InkWell(
                      onTap: () {
                        print("dah 1");
                        saveAppointmentInfo();
                      },
                      child: Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.pink
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(FontAwesomeIcons.donate, color: Colors.white,),
                                SizedBox(width: 1 * (MediaQuery.of(context).size.width/100),),
                                Text("Jom Sumbang", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 2.5 * (MediaQuery.of(context).size.height/100),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans-Bold'
                                ),)
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 60,
      height: 52,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        highlightColor: Colors.black,
        highlightedBorderColor: Colors.black,
        onPressed: press,
        child: Icon(icon, color: Colors.grey[700],),
      ),
    );
  }

  saveAppointmentInfo() {
    print("dah 2");
    int currentQuantity = 0;
    Firestore.instance
        .collection(Sumbang.collectionUserBK)
        .document(widget.model.recordBy)
        .collection(Sumbang.collectionRecordBK)
        .where("recordTime", isEqualTo: widget.model.recordTime)
        .getDocuments()
        .then((docs) {
      currentQuantity = ((docs.documents[0].data['quantityByBK']) -
          (docs.documents[0].data['quantityPending']));
      print("dah 3");
      if (numOfItems > docs.documents[0].data['quantityByBK']) {
        displayDialog("Maaf, kuantiti melebihi keperluan sumbangan.");
      } else if (currentQuantity < numOfItems) {
        displayDialog("Maaf, kuantiti melebihi sumbangan belum diterima.");
      } else if (numOfItems == 0) {
        displayDialog("Sila isi kuantiti yang hendak disumbangkan");
      } else {
        uploadInfoDonate();
      }
    });
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

  uploadInfoDonate() async {
    writeAppointDetailsForInfoDonate({
      "donateBy": Sumbang.sharedPreferences.getString(Sumbang.userUID),
      Sumbang.donationRecordByBK: widget.model.recordBy,
      Sumbang.donationRecordTimeBK: widget.model.recordTime,
      Sumbang.clothCategory: widget.model.clothCategoryByBK,
      Sumbang.genderCategory: widget.model.genderCategoryByBK,
      "donationRecordName": widget.charity.nameNewBK,
      "quantityDonate":numOfItems,
      "quantityBalance": (widget.model.quantityByBK - widget.model.quantityPending),
      "quantityPending": widget.model.quantityPending,
      "donateRecord": DateTime.now().millisecondsSinceEpoch.toString(),
    }).whenComplete(() => {
          completeDonate(),
        });
  }

  completeDonate() {
    Fluttertoast.showToast(msg: "Sumbangan anda telah direkod");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => InfoDonation(),
      ),
    );
  }

  Future writeAppointDetailsForInfoDonate(Map<String, dynamic> data) async {
    await Sumbang.firestore
        .collection(Sumbang.infoDonate)
        .document(Sumbang.sharedPreferences.getString(Sumbang.userUID) +
            data['donateRecord'])
        .setData(data);
  }
}