// import 'package:sumbang_sarong/constants.dart';
// import 'package:flutter/material.dart';
//
// class BKCard extends StatelessWidget {
//   final String productId;
//   final Function onPressed;
//   final String imageAsset;
//   final String title;
//   final String address;
//   final String phone;
//   final String email;
//   final String price;
//   BKCard({this.onPressed, this.imageAsset, this.title, this.address,this.phone,this.email, this.price, this.productId});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       // onTap: () {
//       //   Navigator.push(context, MaterialPageRoute(
//       //     builder: (context) => ProductPage(productId: productId,),
//       //   ));
//       // },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         height: 350.0,
//         margin: EdgeInsets.symmetric(
//           vertical: 12.0,
//           horizontal: 24.0,
//         ),
//         child: Stack(
//           children: [
//             Container(
//               height: 350.0,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12.0),
//                 child: Image.asset(
//                   "$imageAsset",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Row(
//                   mainAxisAlignment:
//                   MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       title,
//                       style: Constants.regularHeading,
//                     ),
//                     Text(
//                       price,
//                       style: TextStyle(
//                           fontSize: 18.0,
//                           color: Theme.of(context).accentColor,
//                           fontWeight: FontWeight.w600
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   mainAxisAlignment:
//                   MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       address,
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       email,
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(
//                       phone,
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }