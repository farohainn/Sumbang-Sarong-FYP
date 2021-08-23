import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Sumbang
{
   static const String appName = 'Sumbang Sarong';

   static SharedPreferences sharedPreferences;
   static FirebaseUser user;
   static FirebaseAuth auth;
   static Firestore firestore ;

   //penyumbang
   static String collectionUser = "penyumbang";
   static String collectionAppointment = "appointmentForPenyumbang";
   static String collectionAppointmentSum = "appointmentForPenyumbangSum";
   static String infoDonate = "InfoDonate";

   //badan kebajikan
   static String collectionUserBK = "badanKebajikan";
   static String collectionRecordBK = "donationRecord";
   static String collectionDetailRecordBK = "donationDetails";
   static String collectionAppointmentBK = "appointmentForBK";
   static String collectionAppointmentBKSum = "appointmentForBKSum";

   //penyumbang
   static final String userName = 'name';
   static final String userEmail = 'email';
   static final String userPhone = 'phone';
   static final String userPhotoUrl = 'photoUrl';
   static final String userUID = 'uid';
   //static final String userAvatarUrl = 'url';

   //badan kebajikan
  static final String userNameBK = 'nameNewBK';
  static final String userEmailBK = 'emailNewBK';
  static final String userPasswdBK = 'passwdNewBK';
  static final String userPhoneBK = 'phoneNewBK';
  static final String userAddressBK = 'addressNewBK';
  static final String userPhotoUrlBK = 'photoUrlBK';
  static final String userUIDBK = 'uidNewBK';
  static final String userAvatarUrlBK = 'urlNewBK';


  //penyumbang
   static final String donationRecordByBK = 'donationRecordByBK';
   static final String donationRecordTimeBK = 'donationRecordTimeBK';
   static final String genderCategory = 'genderCategory';
   static final String clothCategory = 'clothCategory';
   static final String quantityAppointment = 'quantityAppointment';
   static final String quantityPending = 'quantityPending';
   static final String dateAppointment ='dateAppointment';
   static final String timeAppointment ='timeAppointment';
   static final String appointmentRecord ='appointmentRecord';
   static final String isSuccess ='isSuccess';

   //badan kebajikan
   // static final String genderCategoryByBK = 'genderCategoryByBK';
   // static final String clothCategoryByBK = 'clothCategoryByBK';
   // static final String quantityByBK = 'quantityByBK';
   // static final String recordTime ='recordTime';

}