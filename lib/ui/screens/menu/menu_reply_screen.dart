import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/controller/CommonController.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/commonStyles.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';

import 'tree_view_reply_screen.dart';

class MenuReplyScreen extends StatefulWidget {
  const MenuReplyScreen({Key key}) : super(key: key);

  @override
  _MenuReplyScreenState createState() => _MenuReplyScreenState();
}

class _MenuReplyScreenState extends State<MenuReplyScreen> {
  final _formKey = GlobalKey<FormState>();
  var organisationDropDown = "Restaurant";
  var organisationList = ["College", "Restaurant", "Corporate"];
  var database;
  var templateList = ["assets/images/other/image1.jpg",
    "assets/images/other/image2.jpg",
    "assets/images/other/image1.jpg",
    "assets/images/other/image2.jpg"
  ];
  var list = [
    [
      "Hello",
      "How are you",
      "Any Queries",
      "Please provide your email",
      "Please provide your Phone number",
      "Provide your Feedback"
    ],
    [
      "What do you want",
      "How are you",
      "Any Queries",
      "Please provide your email",
      "Please provide your Phonenumber",
      "Provide your Feedback"
    ],
    [
      "How can we help",
      "How are you",
      "Any Queries",
      "Please provide your email",
      "Please provide your Phonenumber",
      "Provide your Feedback"
    ],
    [
      "Welcome to Whatsauto",
      "How are you",
      "Any Queries",
      "Please provide your email",
      "Please provide your Phonenumber",
      "Provide your Feedback"
    ]
  ];

  @override
  void initState() {
    print("${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}");
    // if (CommonController.to.box.read(Globals.TEMPLATE_COUNT) != null){
    //   print("template count: ${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}");
    //   templateList = List<String>.generate(CommonController.to.box.read(Globals.TEMPLATE_COUNT), (index) => 'assets/images/other/image1.jpg');
    // }
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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [_appBar(context), mainView(context)],
            ),
          ),
        )));
  }

  Widget _appBar(context) {
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
                      "Menu Reply",
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

  Widget mainView(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Select Business",
                  style: TextStyle(
                      color: MyColors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          padding: EdgeInsets.only(left: 5.0),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: MyColors.black)],
            borderRadius: BorderRadius.circular(10.0),
            color: MyColors.commonBackgroundColor,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: organisationDropDown,
              icon: Icon(
                Icons.arrow_drop_down,
                color: MyColors.black,
              ),
              iconSize: 22,
              elevation: 16,
              dropdownColor: Colors.white,
              style: TextStyle(color: MyColors.black),
              onChanged: (String newValue) {
                setState(() {
                  organisationDropDown = newValue;
                });
              },
              items: organisationList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: labelTextStyle,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TreeViewReplyScreen(index: null,treeList: CommonController.to.box.read('template_default'),)),
            );
            //     .then((value) {
            //   setState(() {
            //     templateList.length = value;
            //     templateList = List<String>.generate(templateList.length, (index) => 'assets/images/other/image1.jpg');
            //   });
            // });
          },
          child: Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: MyColors.black,
                borderRadius: BorderRadius.circular(18.0),
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/other/fromScratch.png'),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                )),
            child: Center(
              child: Text(
                "Create from \nScratch",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 4,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4 / 4.5,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                final image = templateList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18.0),
                              topRight: Radius.circular(18.0)),
                          child: Image.asset(
                            image,
                            fit: BoxFit.fitWidth,
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              height: 30,
                              width: 70,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TreeViewReplyScreen(index: index+1,treeList: list[index])),
                                  );
                                },
                                child: Text(
                                  'Preview',
                                  style: TextStyle(
                                    color: MyColors.white,
                                    fontSize: 9,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18), // <-- Radius
                                  ),
                                ),
                              ),
                              // width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Container(
                              height: 30,
                              width: 70,
                              child: ElevatedButton(

                                onPressed: () {
                                  setState(() {
                                    CommonController.to.box.write(
                                        Globals.SELECTED_TEMPLATE, index);
                                    /**@author TIJO THOMAS
                                     * @adding data to shared preferences to use in native code
                                     * @since 8-8-2021*/
                                    SharedPreferences.getInstance()
                                        .then((value) {
                                      value.setString(
                                          Globals.SELECTED_TEMPLATE_DATA,
                                          json.encode(list[index]));
                                    });
                                  });
                                },
                                child: CommonController.to.box
                                            .read(Globals.SELECTED_TEMPLATE) ==
                                        index
                                    ? Icon(
                                        Icons.check,
                                        color: MyColors.white,
                                      )
                                    : Text(
                                        'Select',
                                        style: TextStyle(
                                          color: MyColors.white,
                                          fontSize: 9,
                                        ),
                                      ),
                                style: ElevatedButton.styleFrom(
                                    primary: CommonController.to.box.read(
                                                Globals.SELECTED_TEMPLATE) ==
                                            index
                                        ? Colors.green
                                        : Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          18), // <-- Radius
                                    )),
                              ),
                              // width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                );
              }),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
