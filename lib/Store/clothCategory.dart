import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sumbang_sarong/Store/CharityHubList.dart';
import 'package:sumbang_sarong/Store/chooseGender.dart';
import 'package:sumbang_sarong/Store/storehome.dart';

class Choose {
  final String cloth,name,uid;

  const Choose(
      {
        this.cloth,
        this.name,
        this.uid,
      }
      );
}

//------------------------------list view girl

class ClothCategoryGirl extends StatelessWidget {

  final Charity charity;
  ClothCategoryGirl({Key key, this.charity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
          icon: Icon(Icons.close, color: Colors.white,), onPressed: (){
          Route route = MaterialPageRoute(builder: (c)=> CharityHubList());
          Navigator.pushReplacement(context, route);
        },
        ),
        title: Text(
          "Kategori Pakaian",
            style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: getClothCategoryGirlBody(context),
    );
  }


  ListView getClothCategoryGirlBody(BuildContext context){
    final categoryGirl = ['Baju Kurung', 'Baju Lengan Panjang', 'Seluar'];
    final imageClothGirl = ['images/bajukurung.png', 'images/shirt.png', 'images/seluargirl.png'];
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (_, index){
        return Card(
          child: ListTile(
            title: Text(categoryGirl[index]),
            leading: Image.asset(imageClothGirl[index], height: 60.0, width: 60.0,),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new StoreHome(
                      value: Choose(
                        cloth: categoryGirl[index],
                        name: charity.name,
                        uid: charity.uid
                      )
                  ),
                );
                Navigator.of(context).push(route);
              },
            ),
          ),
        );
      },
    );
  }
}

//-----------------------------list view boy

class ClothCategoryBoy extends StatelessWidget {

  final Charity charity;
  ClothCategoryBoy({Key key, this.charity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.pink, Colors.cyanAccent],
              begin: const FractionalOffset(0.0, 0.0,),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white,), onPressed: (){
          Route route = MaterialPageRoute(builder: (c)=> CharityHubList());
          Navigator.pushReplacement(context, route);
        },
        ),
        title: Text(
          "Kategori Pakaian",
          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: getClothCategoryBoyBody(context),
    );
  }


  ListView getClothCategoryBoyBody(BuildContext context) {
    final categoryBoy = ['Baju Melayu', 'Baju Lengan Pendek', 'Seluar.'];
    final imageClothBoy = [
      'images/bajumelayu.png',
      'images/shirtpendek.png',
      'images/seluar.png'
    ];
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            title: Text(categoryBoy[index]),
            leading: Image.asset(
              imageClothBoy[index], height: 60.0, width: 60.0,),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                //Fluttertoast.showToast(msg: categoryBoy[index] + charity.uid);
                var route = new MaterialPageRoute(
                  builder: (BuildContext context) =>
                  new StoreHome(
                      value: Choose(
                          cloth: categoryBoy[index],
                          name: charity.name,
                          uid: charity.uid
                      )
                  ),
                );
                Navigator.of(context).push(route);
              },
            ),
          ),
        );
      },
    );
  }
}




