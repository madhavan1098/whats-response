import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'commonButton.dart';


void showErrorSnackbar(title,message,context) {
  Flushbar(
    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    margin: EdgeInsets.all(15),
    borderRadius: 8,
    backgroundGradient: LinearGradient(
      colors: [Colors.black87, Colors.black],
      stops: [0.6, 1],
    ),
    flushbarPosition:FlushbarPosition.TOP,
    isDismissible: false,
    mainButton: CommonButton(
      width: 80,
      height: 35,
      text: "Close",
      onPressed:(){ Navigator.pop(context);},
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // The default curve is Curves.easeOut
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    message: '$message',
  )..show(context);
}

void showSnackbar(title,message,context) {
  Flushbar(
    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    margin: EdgeInsets.all(15),
    borderRadius: 8,
    backgroundGradient: LinearGradient(
      colors: [Colors.black87, Colors.black],
      stops: [0.6, 1],
    ),
    flushbarPosition:FlushbarPosition.TOP,
    isDismissible: false,
   duration:Duration(seconds: 2),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    // The default curve is Curves.easeOut
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    message: '$message',
  )..show(context);
}