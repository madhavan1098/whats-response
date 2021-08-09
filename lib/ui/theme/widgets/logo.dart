import 'package:flutter/material.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';

class Logo extends StatelessWidget {
  final double height;
  final double width;

  Logo({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: Row(
          children: [
            Image.asset(
              "assets/images/other/app_icon.png",
              fit: BoxFit.fill,
              height: 30,
              width: 30,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "WhatsAuto",
              style:
                  TextStyle(color: MyColors.white, fontWeight: FontWeight.w700),
            )
          ],
        ));
  }
}
