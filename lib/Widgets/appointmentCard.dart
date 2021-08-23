import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sumbang_sarong/Appointments/AppointmentDetailsPage.dart';
import 'package:sumbang_sarong/Models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:sumbang_sarong/Store/storehome.dart';


int counter = 0;
class AppointmentCard extends StatelessWidget
{
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String appointmentID;

  AppointmentCard({Key key, this.itemCount, this.data, this.appointmentID,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()
      {
        Route route = MaterialPageRoute(builder: (c) => AppointmentDetails(appointmentID: appointmentID));
        Navigator.pushReplacement(context, route);
        // Route route;
        // if(counter == 0)
        // {
        //   counter = counter + 1;
        //   route = MaterialPageRoute(builder: (c) => AppointmentDetails(appointmentID: appointmentID));
        // }
        // Navigator.push(context, route);
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



Widget sourceAppointmentInfo(AppointModel model, BuildContext context,
    {Color background})
{
  width =  MediaQuery.of(context).size.width;

  return  Container(
    color: Colors.grey[100],
    height: 150.0,
    width: width,
    child: Row(
      children: [
        model.clothCategory =="Baju Kurung"
            ?
        Image.asset(
          "images/baju4.png", width: 100.0, height: 100.0,)
            :
        model.clothCategory =="Baju Lengan Panjang"
            ?
        Image.asset(
          "images/baju6.png", width: 100.0, height:  100.0,)
            :
        model.clothCategory =="Seluar"
            ?
        Image.asset(
          "images/baju5.png", width: 100.0, height:  100.0,)
            :
        model.clothCategory =="Baju Melayu"
            ?
        Image.asset(
          "images/baju1.png", width: 100.0, height: 100.0,)
            :
        model.clothCategory =="Baju Lengan Pendek"
            ?
        Image.asset(
          "images/baju3.png", width: 100.0, height: 100.0,)
            :
        Image.asset(
          "images/baju2.png", width: 100.0, height: 100.0,),
        SizedBox(width: 10.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.0,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(model.clothCategory, style: TextStyle(color: Colors.black, fontSize: 14.0),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text("Pakaian " + model.genderCategory, style: TextStyle(color: Colors.black54, fontSize: 12.0),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text("Kuantiti sumbangan: " + (model.quantityAppointment).toString(), style: TextStyle(color: Colors.black54, fontSize: 12.0),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text("Tarikh janji temu: " + model.dateAppointment, style: TextStyle(color: Colors.black54, fontSize: 12.0),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text("Masa janji temu: " + model.timeAppointment, style: TextStyle(color: Colors.black54, fontSize: 12.0),),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(),
              ),

              Divider(
                height: 5.0,
                color: Colors.pink,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
