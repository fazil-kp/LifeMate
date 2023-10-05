// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
//
// class AppTextStyles {
//   static TextStyle headerTextStyle({Color color = Colors.white}) {
//     return GoogleFonts.signikaNegative(
//       fontSize: 18,
//       fontWeight: FontWeight.w600,
//       color: color,
//     );
//   }
//
//   static TextStyle montserratStyle(
//       {required Color color, double fontSize = 24}) {
//     return GoogleFonts.montserrat(
//       color: color,
//       fontWeight: FontWeight.w800,
//       fontSize: fontSize,
//     );
//   }
//
//   static TextStyle headingStyles(
//       {double fontSize = 36, Color color = Colors.white}) {
//     return GoogleFonts.rubikMoonrocks(
//       fontSize: fontSize,
//       fontWeight: FontWeight.bold,
//       color: color,
//       letterSpacing: 2,
//     );
//   }
//
//   static TextStyle normalStyle(
//       {Color color = Colors.white, double fontSize = 16}) {
//     return TextStyle(
//       fontWeight: FontWeight.w500,
//       fontSize: fontSize,
//       color: color,
//       letterSpacing: 1.7,
//       height: 1.5,
//     );
//   }
//
//   static TextStyle comfortaaStyle() {
//     return GoogleFonts.comfortaa(
//         fontSize: 18, fontWeight: FontWeight.w800, color: Colors.grey);
//   }
// }
//
// class HelperClass extends StatelessWidget {
//   final Widget mobile;
//   final Widget tablet;
//   final Widget desktop;
//   final double paddingWidth;
//   final Color bgColor;
//
//   const HelperClass({
//     Key? key,
//     required this.mobile,
//     required this.tablet,
//     required this.desktop,
//     required this.paddingWidth,
//     required this.bgColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (constraints.maxWidth < 768) {
//           return Container(
//             width: size.width,
//             alignment: Alignment.center,
//             color: bgColor,
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//             child: mobile,
//           );
//         } else if (constraints.maxWidth < 1200) {
//           return Container(
//             width: size.width,
//             alignment: Alignment.center,
//             color: bgColor,
//             padding: EdgeInsets.symmetric(vertical: 40, horizontal: paddingWidth),
//             child: tablet,
//           );
//         } else {
//           return Container(
//             width: size.width,
//             alignment: Alignment.center,
//             color: bgColor,
//             padding: EdgeInsets.symmetric(vertical: 60, horizontal: paddingWidth),
//             child: desktop,
//           );
//         }
//       },
//     );
//   }
// }
//
//
//
//
// class AppAssets {
//   static String facebook = 'assets/images/face.png';
//   static String github = 'assets/images/git.png';
//   static String linkedIn = 'assets/images/in.png';
//   static String insta = 'assets/images/insta.png';
//   static String twitter = 'assets/images/twit.png';
//   static String profile1 = 'assets/images/pro1.png';
//   static String profile2 = 'assets/images/pro1.png';
//   static String code = 'assets/images/coding.png';
//   static String brush = 'assets/images/brush-stroke.png';
//   static String analyst = 'assets/images/analytics.png';
//   static String work1 = 'assets/images/work1.jpg';
//   static String work2 = 'assets/images/work2.jpg';
//   static String share = 'assets/images/share.png';
//   static String xshare = 'assets/images/twit.png';
// }
//
//
// class Constants {
//   static SizedBox sizedBox({height, width}) {
//     return SizedBox(
//       height: height,
//       width: width,
//     );
//   }
// }
// class AppColors {
//   static Color bgColor = const Color(0xff002147);
//   static Color themeColor = const Color(0xff99FFFF);
//   static Color aqua = const Color(0xff007A74);
//   static Color lawGreen = const Color(0xff7CFC00);
//   static Color bgColor2 = const Color(0xff00416A);
//   static Color robinEdgeBlue = const Color(0xff00CCCC);
//   static Color white = const Color(0xffffffff);
// }
//
// class AppButtons {
//   static MaterialButton buildMaterialButton({
//     required String buttonName,
//     required VoidCallback onTap,
//   }) {
//     return MaterialButton(
//       onPressed: onTap,
//       color: AppColors.themeColor,
//       splashColor: AppColors.lawGreen,
//       padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
//       shape: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
//       hoverColor: AppColors.aqua,
//       elevation: 7,
//       height: 46,
//       minWidth: 130,
//       focusElevation: 12,
//       child: Text(
//         buttonName,
//         style: AppTextStyles.headerTextStyle(color: Colors.black),
//       ),
//     );
//   }
// }
