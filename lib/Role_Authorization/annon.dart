import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  FirebaseAuth auth = FirebaseAuth.instance;

  Future signInAnon() async{
    try{
      final result = await auth.signInAnonymously();
      return result.user;
    } catch(e){
      print(e);
      return null;
    }
  }

}