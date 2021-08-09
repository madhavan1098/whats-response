import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';

import '../MyColors.dart';

class LoadingWidget extends StatelessWidget {
final bool center;
LoadingWidget({this.center=false});
  @override
  Widget build(BuildContext context) {
    return center==true?
    Center(child: CommonLoadingWidget()):
    CommonLoadingWidget();
  }
}


class CommonLoadingWidget extends StatefulWidget {

  final bool loading;
  CommonLoadingWidget({this.loading});

  @override
  _CommonLoadingWidgetState createState() => new _CommonLoadingWidgetState();
}
class _CommonLoadingWidgetState extends State<CommonLoadingWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 7),
    );

    animationController.repeat();

    Timer(Duration(seconds:1),
            () {
          if (!mounted) return;
          setState(() {
            _bigger=true;
          });
        } );
  }

  @override
  void dispose(){
    animationController.stop();
    animationController.dispose();
    super.dispose();
  }

  bool _bigger=false;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        new AnimatedBuilder(
          animation: animationController,
          child: Container(
            height:50,
            width:50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[200],
                      blurRadius: 4.0,
                      spreadRadius: 2),
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: new Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.white
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(MyColors.primaryColor))
                  //Image.asset('assets/images/nandilathAppLogo.png'),
                ),
              ),
            ),
          ),
          builder: (BuildContext context, Widget _widget) {
            return new Transform.rotate(
              angle: animationController.value * 30.3,
              child: _widget,
            );
          },
        ),
      ],
    );
  }
}

