import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}

// class MyColors {
//   static const Color primaryColor = const Color(0xffd60265);
//   static const Color secondaryColor = const Color(0xffd60265);
//   static const MaterialColor navy = MaterialColor(
//     0xffd60265,
//     <int, Color>{
//       50: Color(0xffd60265),
//       100: Color(0xffd60265),
//       200: Color(0xffd60265),
//       300: Color(0xffd60265),
//       400: Color(0xffd60265),
//       500: Color(0xffd60265),
//       600: Color(0xffd60265),
//       700: Color(0xffd60265),
//       800: Color(0xffd60265),
//       900: Color(0xffd60265),
//     },
//   );
// }
