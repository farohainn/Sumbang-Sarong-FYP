// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sumbang_sarong/Config/config.dart';
// import 'package:sumbang_sarong/DialogBox/errorDialog.dart';
// import 'package:sumbang_sarong/Store/appointmenForm.dart';
//
// class InfoDonation extends StatefulWidget {
//   @override
//   _InfoDonationState createState() => _InfoDonationState();
// }
//
// class _InfoDonationState extends State<InfoDonation> {
//
//   TextEditingController editingController = TextEditingController();
//
//   buildTextField(TextEditingController controller, String labelText){
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: Colors.white, border: Border.all(color: Colors.cyan)
//       ),
//       child: TextField(
//         keyboardType: TextInputType.number,
//         controller: controller,
//         style: TextStyle(
//           color: Colors.black
//         ),
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
//           labelText: labelText,
//           labelStyle: TextStyle(color: Colors.black),
//           border: InputBorder.none
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text("Info Sumbangan", style: TextStyle(color: Colors.black, fontSize: 30.0),),
//       ),
//       backgroundColor: Colors.white,
//       body: StreamBuilder<QuerySnapshot>(
//         stream: Firestore.instance.collection(Sumbang.infoDonate).where("donateBy", isEqualTo: Sumbang.sharedPreferences.getString(Sumbang.userUID)).snapshots(),
//         builder: (context, dataSnapshot) {
//           return !dataSnapshot.hasData
//               ? Center(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Maaf tiada rekod keperluan sumbangan.",
//                     style: TextStyle(
//                         color: Colors.pink,
//                         fontSize: 24.0,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               )
//               : ListView.builder(
//                   itemCount: dataSnapshot.data.documents.length,
//                   itemBuilder: (context, index) {
//                     var doc = dataSnapshot.data.documents[index].data;
//                     return ListTile(
//                       leading: IconButton(
//                         icon: Icon(Icons.edit),
//                         iconSize: 50.0,
//                         color: Colors.cyan,
//                         onPressed: (){
//
//                           editingController.text= doc['quantityDonate'].toString();
//
//                           showDialog(
//                             context: context,
//                             builder: (context) => Dialog(
//                               child: Container(
//                                 color: Colors.grey,
//                                 child: ListView(
//                                   shrinkWrap: true,
//                                   children: <Widget>[
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                                       decoration: BoxDecoration(
//                                           color: Colors.grey, border: Border.all(color: Colors.cyan)
//                                       ),
//                                       child: Text(
//                                         doc['donationRecordName'],
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 20.0,),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                                       decoration: BoxDecoration(
//                                           color: Colors.grey, border: Border.all(color: Colors.cyan)
//                                       ),
//                                       child: Text(
//                                         doc['clothCategory'],
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 20.0,),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                                       decoration: BoxDecoration(
//                                           color: Colors.grey, border: Border.all(color: Colors.cyan)
//                                       ),
//                                       child: Text( "Pakaian " +
//                                         doc['genderCategory'],
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 20.0,),
//                                     buildTextField(editingController, "Kuantiti Sumbangan"),
//                                     SizedBox(height: 20.0,),
//                                     FlatButton(
//                                         onPressed: (){
//                                           if(int.parse(editingController.text) < doc['quantityBalance']){
//                                             dataSnapshot.data.documents[index]
//                                                 .reference
//                                                 .updateData({
//                                               "quantityDonate": int.parse(editingController.text)
//                                             }).whenComplete(() => Navigator.pop(context));
//                                           }else{
//                                             displayDialog("Maaf, kuantiti melebihi keperluan sumbangan.");
//                                           }
//                                         },
//                                         color: Colors.cyan,
//                                         child: Padding(
//                                           padding: EdgeInsets.all(16.0),
//                                           child: Text("Ubah Kuantiti Sumbangan", style: TextStyle(color: Colors.white),),
//                                         ),
//                                     ),
//                                     SizedBox(height: 20.0,),
//                                     FlatButton(
//                                         onPressed: (){
//                                           dataSnapshot.data.documents[index]
//                                               .reference
//                                               .delete();
//                                         },
//                                         color: Colors.pink,
//                                         child: Padding(
//                                           padding: EdgeInsets.all(16.0),
//                                           child: Text("Padam Sumbangan",style: TextStyle(color: Colors.white),),
//                                         ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           );
//                         },
//                       ),
//                       title: Text(
//                         doc['donationRecordName'],
//                         style: TextStyle(color: Colors.grey[800]),
//                       ),
//                       subtitle: Column(
//                         children: <Widget>[
//                           Text(
//                             doc['clothCategory'],
//                             style: TextStyle(color: Colors.grey[800]),
//                           ),
//                           Text(
//                             doc['genderCategory'],
//                             style: TextStyle(color: Colors.grey[800]),
//                           ),
//                           Text(
//                             doc['quantityDonate'].toString() + " Helai",
//                             style: TextStyle(color: Colors.grey[800]),
//                           ),
//                         ],
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.airport_shuttle, color: Colors.pink),
//                         iconSize: 50.0,
//                         onPressed: (){
//                           if(doc['quantityDonate'] < doc['quantityBalance']){
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => AppointmentForm(
//                                   recordName: doc['donationRecordName'],
//                                   clothCategory: doc['clothCategory'],
//                                   genderCategory: doc['genderCategory'],
//                                   quantityDonate: doc['quantityDonate'],
//                                   recordby: doc['donationRecordByBK'],
//                                   recordTime: doc['donationRecordTimeBK'],
//                                   quantityPending: doc['quantityPending'],
//                                   donateRecord: doc['donateRecord'],
//                                 ),
//                               ),
//                             );
//                           }else{
//                             displayDialog("Maaf, kuantiti melebihi keperluan sumbangan TERKINI. Sila padam atau ubah kuantiti.");
//                           }
//                         },
//                       ),
//                     );
//                   });
//         },
//       ),
//     );
//   }
//   displayDialog(String msg) {
//     showDialog(
//         context: context,
//         builder: (c) {
//           return ErrorAlertDialog(message: msg,);
//         }
//     );
//   }
// }
