import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/ui/screens/menu/tree_view_reply_screen.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';

class TreeViewScreen extends StatefulWidget {
  const TreeViewScreen({Key key}) : super(key: key);

  @override
  _TreeViewScreenState createState() => _TreeViewScreenState();
}

class _TreeViewScreenState extends State<TreeViewScreen> {
  final _formKey = GlobalKey<FormState>();
  final box = GetStorage();
  List<String> messageList = [];

  @override
  void initState() {
    refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        backgroundColor: MyColors.white,
        child: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: MyColors.white,
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [_appBar(), mainView()],
            ),
          ),
        )));
  }

  Widget _appBar() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: MyColors.primaryColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 6.0,
                  offset: Offset(2.0, 4.0), //(x,y)
                  spreadRadius: 1),
            ]),
        child: Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 10),
                  height: 60,
                  child: Icon(
                    Icons.arrow_back,
                    color: MyColors.white,
                  ),
                ),
              ),
              Container(
                  height: 60,
                  child: Center(
                    child: Text(
                      "Menu Tree View",
                      style: TextStyle(
                          color: MyColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget mainView() {
    return Column(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            return Align(
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    messageList[index],
                    style: TextStyle(color: MyColors.white),
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: MyColors.green,
                    borderRadius: BorderRadius.circular(10)),
              ),
              alignment: Alignment.topRight,
            );
          },
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TreeViewReplyScreen()),
              ).then((value) => refreshData());
            },
            icon: Icon(
              Icons.add,
              color: MyColors.white,
            ),
            label: Text(
              "Create Reply",
              style: TextStyle(
                  color: MyColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => getColor(states))),
          ),
        )
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.black38;
    }
    return MyColors.black;
  }

  void refreshData() {
    if (box.read(Globals.MENU_REPLY_DATA) != null) {
      var message = box.read(Globals.MENU_REPLY_DATA);
      setState(() {
        if (!messageList.contains(message)) messageList.add(message);
      });
    }
  }
}
