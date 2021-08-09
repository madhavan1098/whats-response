import 'package:flutter/material.dart';

import 'MyColors.dart';

final ThemeData appThemeData = ThemeData(
  primaryColor: Color.fromRGBO(219, 11, 11, 1),
  accentColor: Color.fromRGBO(0, 0, 0, 1),
  splashColor: Color.fromRGBO(190, 0, 0, 1),
  highlightColor: Color.fromRGBO(219, 11, 11, 1),
  fontFamily: 'Poppins_Regular',
  iconTheme: IconThemeData(color: MyColors.primaryColor),
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
  ),
  cardColor: Colors.white,
  // Background color of the FloatingCard
  buttonTheme: ButtonThemeData(
    buttonColor: MyColors.secondaryColor, // Select here's button color
    textTheme: ButtonTextTheme
        .primary, // Applying this will automatically change text color based on buttonColor. (Button color is dark ? white / is light ? black)
  ),
);
