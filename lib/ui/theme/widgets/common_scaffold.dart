import 'package:flutter/material.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';

class CommonScaffold extends StatelessWidget {
  final Widget child;
  final Widget appBar;
  final Color backgroundColor;
  final FloatingActionButton floatingActionButton;

  const CommonScaffold(
      {Key key,
      this.backgroundColor,
      this.appBar,
      this.child,
      this.floatingActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton:
          floatingActionButton != null ? floatingActionButton : null,
      backgroundColor: MyColors.commonBackgroundColor,
      appBar: appBar != null ? appBar : null,
      body: child,
    );
  }
}
