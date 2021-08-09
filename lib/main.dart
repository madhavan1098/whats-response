import 'package:flutter/material.dart';
import 'package:whatsauto/controller/CommonController.dart';
import 'package:whatsauto/ui/screens/home/homeMain.dart';
import 'package:whatsauto/ui/theme/app_theme.dart';

void main() {
  runApp(MyApp());
  CommonController.to.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsAuto',
      debugShowCheckedModeBanner: false,
      theme: appThemeData,
      home: HomeMainScreen(),
    );
  }
}
