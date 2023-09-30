// import 'package:flutter/material.dart';
//
// class UserHomepage extends StatelessWidget {
//   const UserHomepage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               width: w,
//               height: h * 0.3,
//               decoration: BoxDecoration(
//                 color: Colors.redAccent,
//                 image: DecorationImage(
//                   fit: BoxFit.contain,
//                   image: AssetImage("assets/images/LoginPageImage.png"),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: h * 0.16,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 20, right: 20),
//               width: w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//               ),
//             ),
//             SizedBox(
//               height: 70,
//             ),
//             Container(
//               width: w,
//               margin: EdgeInsets.only(left: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Welcome",
//                     style: TextStyle(fontSize: 36, color: Colors.black54),
//                   ),
//                   Text(
//                     "abcd@gmail.com",
//                     style: TextStyle(fontSize: 18, color: Colors.grey[500]),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 200,),
//
//             Container(
//               width: w * 0.5,
//               height: h * 0.08,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 color: Colors.redAccent,
//               ),
//               child: Center(
//                 child: Text(
//                   "Log out",
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
