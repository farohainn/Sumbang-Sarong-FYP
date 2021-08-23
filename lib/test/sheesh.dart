import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Config/config.dart';
import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
import 'package:sumbang_sarong/Store/appointmenForm.dart';
import 'package:sumbang_sarong/Widgets/myDrawer.dart';


class InfoDonation extends StatefulWidget {
  @override
  _InfoDonationState createState() => _InfoDonationState();
}

class _InfoDonationState extends State<InfoDonation> {

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController editingController = TextEditingController();

  buildTextField(TextEditingController controller, String labelText){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.cyan)
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        style: TextStyle(
            color: Colors.black
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            border: InputBorder.none
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          iconSize: 30.0,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.menu, size: 30.0, color: Colors.black,),
                onPressed: (){
                  scaffoldKey.currentState.openDrawer();
                },
              ),
            ],
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Info Sumbangan',
              style: TextStyle(
                  fontFamily: 'avenir',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 30),
            ),
            SizedBox(height: 30.0,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection(Sumbang.infoDonate).where("donateBy", isEqualTo: Sumbang.sharedPreferences.getString(Sumbang.userUID)).snapshots(),
                  builder: (context, dataSnapshot){
                    return !dataSnapshot.hasData
                        ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Tiada Rekod",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                        : ListView.builder(
                        itemCount: dataSnapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          var doc = dataSnapshot.data.documents[index].data;
                          return Container(
                              margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.pink[700], Colors.pink[200]],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: [Colors.pink[700], Colors.pink[400]].last.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.label,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              doc['donationRecordName'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'avenir',
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.airport_shuttle),
                                          iconSize: 50.0,
                                          color: Colors.blue[900],
                                          onPressed: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => AppointmentForm(
                                                  recordName: doc['donationRecordName'],
                                                  clothCategory: doc['clothCategory'],
                                                  genderCategory: doc['genderCategory'],
                                                  quantityDonate: doc['quantityDonate'],
                                                  recordby: doc['donationRecordByBK'],
                                                  recordTime: doc['donationRecordTimeBK'],
                                                  quantityPending: doc['quantityPending'],
                                                  donateRecord: doc['donateRecord'],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                  ),
                                  Text(
                                    doc['clothCategory'] + ", " + doc['genderCategory'],
                                    style: TextStyle(
                                        color: Colors.white, fontFamily: 'avenir', fontSize: 15.0),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        doc['quantityDonate'].toString() + " Helai",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'avenir',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        iconSize: 50.0,
                                        color: Colors.blue[900],
                                        onPressed: (){

                                          editingController.text= doc['quantityDonate'].toString();

                                          showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Container(
                                                  color: Colors.transparent,
                                                  child: ListView(
                                                    shrinkWrap: true,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey[350], border: Border.all(color: Colors.cyan)
                                                        ),
                                                        child: Text(
                                                          doc['donationRecordName'],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.0
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.0,),
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey[350], border: Border.all(color: Colors.cyan)
                                                        ),
                                                        child: Text(
                                                          doc['clothCategory'],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.0
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.0,),
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey[350], border: Border.all(color: Colors.cyan)
                                                        ),
                                                        child: Text( "Pakaian " +
                                                            doc['genderCategory'],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 15.0
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.0,),
                                                      buildTextField(editingController, "Kuantiti Sumbangan"),
                                                      SizedBox(height: 20.0,),
                                                      FlatButton(
                                                        onPressed: (){
                                                          if(int.parse(editingController.text) < doc['quantityBalance']){
                                                            dataSnapshot.data.documents[index]
                                                                .reference
                                                                .updateData({
                                                              "quantityDonate": int.parse(editingController.text)
                                                            }).whenComplete(() => Navigator.pop(context));
                                                          }else{
                                                            displayDialog("Maaf, kuantiti melebihi keperluan sumbangan.");
                                                          }
                                                        },
                                                        color: Colors.cyan,
                                                        child: Padding(
                                                          padding: EdgeInsets.all(16.0),
                                                          child: Text("Ubah Kuantiti Sumbangan", style: TextStyle(color: Colors.white),),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20.0,),
                                                      FlatButton(
                                                        onPressed: (){
                                                          dataSnapshot.data.documents[index]
                                                              .reference
                                                              .delete().whenComplete(() => Navigator.pop(context));
                                                        },
                                                        color: Colors.pink,
                                                        child: Padding(
                                                          padding: EdgeInsets.all(16.0),
                                                          child: Text("Padam Sumbangan",style: TextStyle(color: Colors.white),),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                            ),
                          );
                        });
                  }
              ),
            ),
          ],
        ),
      ),
    );
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