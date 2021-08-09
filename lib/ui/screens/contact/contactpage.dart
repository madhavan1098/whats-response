import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';
import 'package:whatsauto/ui/theme/widgets/logo.dart';

import 'contactSelection.dart';

class ContactPageScreen extends StatefulWidget {
  @override
  _ContactPageScreenState createState() => _ContactPageScreenState();
}

class _ContactPageScreenState extends State<ContactPageScreen> {
  var contactListing = [
    "Everyone",
    "Select people from contact list",
    "Except my contact list",
    "Except my phone contacts",
    "Enable Groups"
  ];

  var radioValue = 0;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    if (box.read(Globals.RECIVE_OPTION) != null) {
      radioValue = box.read(Globals.RECIVE_OPTION);
    }
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
              children: [
                _appBar(_formKey),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        "Who receives your greeting message",
                        style: TextStyle(
                          fontSize: 15,
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _radioList(radioValue)
              ],
            ),
          ),
        )));
  }

  Widget _appBar(_formKey) {
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
              Container(
                  height: 60,
                  child: Logo(
                    height: 25,
                    width: 115,
                  )),
              Spacer(),
              Container(
                height: 60,
                child: InkWell(
                  onTap: () {},
                  child: SvgPicture.asset(
                    "assets/images/svg/more.svg",
                    color: MyColors.white,
                    height: 20,
                    width: 20,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _radioList(radioValue) {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RadioListTile(
                value: index,
                activeColor: MyColors.green,
                groupValue: radioValue,
                onChanged: (ind) {
                  print("$ind");
                  radioValue = ind;
                  box.write(Globals.RECIVE_OPTION, radioValue);

                  if (radioValue == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactSelectionPageScreen()),
                    ).then((value) {
                      setState(() {});
                    });
                  } else {
                    setState(() {});
                  }
                },
                title: index == 1
                    ? box.read(Globals.RECIVE_OPTION) != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${contactListing[index]}"),
                              Row(
                                children: [
                                  Text(
                                    "Selected Contacts: ${box.read(Globals.SELECTEDLIST) == null ? "0" : box.read(Globals.SELECTEDLIST).length}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: MyColors.primaryColor),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContactSelectionPageScreen()),
                                      );
                                    },
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: MyColors.grey,
                                      size: 15,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        : Text("${contactListing[index]}")
                    : Text("${contactListing[index]}"),
              ),
            ],
          ),
        );
      },
      itemCount: contactListing.length,
    ));
  }
}
