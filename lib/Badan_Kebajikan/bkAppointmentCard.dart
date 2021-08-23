import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/bkAppointmentDetails.dart';
import 'package:sumbang_sarong/Models/appointment.dart';
import 'package:sumbang_sarong/Store/storehome.dart';
import 'package:sumbang_sarong/Widgets/appointmentCard.dart';


int counter=0;
class BKAppointmentCard extends StatelessWidget
{
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String appointmentID;
  final String appointmentBy;


  BKAppointmentCard({Key key, this.itemCount, this.data, this.appointmentID, this.appointmentBy,}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return  InkWell(
      onTap: ()
      {

        Route route = MaterialPageRoute(builder: (c) => BKAppointmentDetails(appointmentID: appointmentID, appointmentBy: appointmentBy,));
        Navigator.pushReplacement(context, route);
        
      },
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.pink, Colors.cyanAccent],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        height: itemCount * 190.0,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (c, index)
          {
            AppointModel model = AppointModel.fromJson(data[index].data);
            return sourceAppointmentInfo(model, context);
          },
        ),
      ),
    );
  }
}


