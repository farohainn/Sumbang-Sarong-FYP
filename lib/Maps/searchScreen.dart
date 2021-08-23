import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sumbang_sarong/Badan_Kebajikan/BKRegister.dart';
import 'package:sumbang_sarong/DialogBox/loadingDialog.dart';
import 'package:sumbang_sarong/Maps/Assistants/requestAssistants.dart';
import 'package:sumbang_sarong/Maps/Divider.dart';
import 'package:sumbang_sarong/Maps/configMaps.dart';
import 'package:sumbang_sarong/Maps/placePredictions.dart';

import 'DataHandler/appData.dart';
import 'MapPage.dart';
import 'address.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override

  TextEditingController dropOffTextEditingController = TextEditingController();
  TextEditingController pickUpTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];

  Widget build(BuildContext context) {

    String placeAddress = Provider.of<AppData>(context).pickUpLocation.placeName ?? "";
    pickUpTextEditingController.text = placeAddress;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.pinkAccent[700],
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7,0.7),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 20.0,),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MapPage()));
                        },
                        child: Icon(
                            Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text("Cari Lokasi Rumah Kebajikan", style: TextStyle(fontSize: 18.0, fontFamily: "Brand-Bold", color: Colors.white),),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0,),
                  Row(
                    children: [

                      Text("Mula", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),),

                      SizedBox(width: 18.0,),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: pickUpTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Saya berada disini",
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  Row(
                    children: [

                      Text("Akhir", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),),

                      SizedBox(width: 18.0,),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              onChanged: (val){
                                findPlace(val);
                              },
                              controller: dropOffTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Alamat/Nama Rumah Kebajikan",
                                fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),

          //tile for predictions
          SizedBox(height: 10.0,),
          (placePredictionList.length > 0)
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListView.separated(
                padding: EdgeInsets.all(0.0),
              itemBuilder: (context, index){
                  return PredictionTile(placePredictions: placePredictionList[index],);
              },
              separatorBuilder: (BuildContext context, int index) => DividerWidget(),
              itemCount: placePredictionList.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            ),
          )
              : Container(),
        ],
      ),
    );
  }

  void findPlace (String placeName) async{
    if(placeName.length > 1){
      String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:my";

      var res = await RequestAssistants.getRequest(autoCompleteUrl);

      if(res == "failed"){
        return;
      }

      if(res["status"] == "OK"){
        var predictions = res["predictions"];

        var placeList = (predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();

        setState(() {
          placePredictionList = placeList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {

  final PlacePredictions placePredictions;

  PredictionTile({Key key, this.placePredictions}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0,),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(width : 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0,),
                      Text(placePredictions.main_text, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.0),),
                      SizedBox(height: 2.0,),
                      Text(placePredictions.secondary_text, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.0, color: Colors.grey),),
                      SizedBox(height: 8.0,),
                    ],
                  ),
                ),
                SizedBox(width: 10.0,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async{
    showDialog(
        context: context,
      builder: (BuildContext context) => LoadingAlertDialog(message: "Sedang Mengemaskini, Sila Tunggu...",)
    );

    String placeDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var res = await RequestAssistants.getRequest(placeDetailsUrl);

    Navigator.pop(context);

    if(res == "failed"){
      return;
    }
    if(res["status"] == "OK"){
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false).updateDropOffLocationAddress(address);
      print("This is Drop Off location ::");
      print(address.placeName);
      
      Navigator.pop(context, "obtainDirection");
    }
  }
}
