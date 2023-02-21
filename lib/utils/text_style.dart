import 'package:flutter/material.dart';
import 'package:lettutor/utils/utils.dart';

// AppBar appBar(String title, BuildContext context) {
//     return AppBar(
//       backgroundColor: Theme.of(context).primaryColor,
//       title: Text(title,
//         style: const TextStyle(
//         color: Colors.white,
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//       ),
//         textAlign: TextAlign.justify,
//       ),
//     );
// }
class DefaultColor {
  late Color fontColor = Colors.black;
  late Color backgroundColor = Colors.transparent;

  DefaultColor(){
    if (getDeviceThemeMode() == ThemeMode.light) {
      fontColor =  Colors.black;
      backgroundColor = Colors.transparent;
    } else {
      fontColor =  Colors.white;
      backgroundColor = Colors.black;
    }
  }

}

TextStyle? bodyLarge(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge?.copyWith(
    fontWeight: FontWeight.w400,
    color: DefaultColor().fontColor,
    backgroundColor: DefaultColor().backgroundColor
  );
}

TextStyle? bodyLargeBold(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge?.copyWith(
    fontWeight: FontWeight.w500,
    color: DefaultColor().fontColor,
    backgroundColor: DefaultColor().backgroundColor
  );
}

TextStyle? headLineSmall(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w500,
      color: DefaultColor().fontColor,
      backgroundColor: DefaultColor().backgroundColor
  );
}

TextStyle? headLineMedium(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium?.copyWith(
    fontWeight: FontWeight.w500,
    color: DefaultColor().fontColor,
    backgroundColor: DefaultColor().backgroundColor
  );
}