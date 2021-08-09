import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/model/more_model.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/commonStyles.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';
import 'package:whatsauto/ui/theme/widgets/logo.dart';

import 'more_detail.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  var moreItemList = [
    MoreModel(name: "Schedule App", icon: Icons.schedule),
    MoreModel(name: "Set Reply Time", icon: Icons.timelapse_outlined),
    MoreModel(name: "Security", icon: Icons.security),
    MoreModel(name: "Other Options", icon: null),
    MoreModel(name: "Help", icon: Icons.help),
    MoreModel(name: "Share App", icon: Icons.share),
    MoreModel(name: "Rate App", icon: Icons.rate_review),
    MoreModel(name: "Privacy", icon: Icons.privacy_tip)
  ];
  StateSetter _setState;
  final _formKey = GlobalKey<FormState>();
  var scheduleRadioValue = 1;
  var replyRadioValue = 1;
  var isSecurityEnabled = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      var isAllowed = value.getBool(Globals.SECURITY_ALLOWED);
      if (isAllowed != null) {
        if (mounted) {
          setState(() {
            isSecurityEnabled = isAllowed;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog scheduleDialog = AlertDialog(
      title: Text('Schedule App'),
      contentPadding: EdgeInsets.zero,
      content: StatefulBuilder(
        builder: (context, state) {
          _setState = state;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                value: 1,
                activeColor: MyColors.green,
                groupValue: scheduleRadioValue,
                onChanged: (ind) {
                  print("$ind");
                  _setState(() {
                    scheduleRadioValue = ind;
                  });
                },
                title: Text("Activate time to turn App automatically on"),
              ),
              RadioListTile(
                value: 2,
                activeColor: MyColors.green,
                groupValue: scheduleRadioValue,
                onChanged: (ind) {
                  print("$ind");
                  _setState(() {
                    scheduleRadioValue = ind;
                  });
                },
                title: Text("Set time to automatically off"),
              ),
              RadioListTile(
                value: 3,
                activeColor: MyColors.green,
                groupValue: scheduleRadioValue,
                onChanged: (ind) {
                  print("$ind");
                  _setState(() {
                    scheduleRadioValue = ind;
                  });
                },
                title: Text("Play Notification on or off automatically"),
              ),
              RadioListTile(
                value: 4,
                activeColor: MyColors.green,
                groupValue: scheduleRadioValue,
                onChanged: (ind) {
                  print("$ind");
                  _setState(() {
                    scheduleRadioValue = ind;
                  });
                },
                title: Text(
                    "Turn App automatically on when the phone is screen locked or idle"),
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    );
    AlertDialog replyDialog = AlertDialog(
      title: Text('Set Reply Time'),
      contentPadding: EdgeInsets.zero,
      content: StatefulBuilder(
        builder: (context, state) {
          _setState = state;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                value: 1,
                activeColor: MyColors.green,
                groupValue: replyRadioValue,
                onChanged: (ind) {
                  print("$ind");
                  _setState(() {
                    replyRadioValue = ind;
                  });
                },
                title: Text("Don't Delay"),
              ),
              RadioListTile(
                value: 2,
                activeColor: MyColors.green,
                groupValue: replyRadioValue,
                onChanged: (ind) {
                  print("$ind");
                  _setState(() {
                    replyRadioValue = ind;
                  });
                },
                title: Text("Time Delay"),
              ),
              RadioListTile(
                value: 3,
                activeColor: MyColors.green,
                groupValue: replyRadioValue,
                onChanged: (ind) {
                  print("$ind");
                  _setState(() {
                    replyRadioValue = ind;
                  });
                },
                title: Text("Reply once"),
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    );
    return SafeArea(
      child: CommonScaffold(
        backgroundColor: MyColors.white,
        child: Column(
          children: [
            _appBar(_formKey),
            ListView.builder(
                shrinkWrap: true,
                itemCount: moreItemList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      var contentArray;
                      if (index == 0) {
                        contentArray = [
                          "Activate time to turn App automatically on",
                          "Set time to automatically off",
                          "Play Notification on or off automatically",
                          "Turn App automatically on when the phone is screen locked or idle"
                        ];
                      }else if (index == 1){
                        contentArray = [
                          "Don't Delay",
                          "Time Delay",
                          "Reply once",
                        ];

                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoreDetailScreen(content: contentArray,title:"${moreItemList[index].name}",)),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),

                      height:index >= 3 && index < moreItemList.length ? index == 3 ? 20 : 50 : 60,
                      child: Row(
                        children: [
                          index == 3
                          ? SizedBox()
                          : Padding(padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            moreItemList[index].icon,
                            size: 30,
                            color: MyColors.greyColor,
                          ),),
                          SizedBox(
                            width: 35,
                          ),

                         index >= 3 && index < moreItemList.length
                          ?  index == 3
                            ? Text("${moreItemList[index].name}",style: TextStyle(color: MyColors.green,fontSize: 14,fontWeight: FontWeight.w400))

                            : Text("${moreItemList[index].name}",style: TextStyle(color: MyColors.black,fontSize: 16,fontWeight: FontWeight.w700))
                         : Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [

                               Text("${moreItemList[index].name}",style: TextStyle(color: MyColors.black,fontSize: 16,fontWeight: FontWeight.w700)),
                               SizedBox(height: 10,),
                               index == 0
                               ? Expanded(child: Text("Set, Reset Application for auto reply",style: TextStyle(color: MyColors.grey,fontSize: 14,fontWeight: FontWeight.w400),),)
                                   : index == 1
                                     ? Text("Schedule a timer for message reply",style: TextStyle(color: MyColors.grey,fontSize: 14,fontWeight: FontWeight.w400),)
                                       : index == 2
                                         ? Text("Lock your Application",style: TextStyle(color: MyColors.grey,fontSize: 14,fontWeight: FontWeight.w400),)
                                           :  Text(""),


                             ],
                           ),
                         ),
                          if (index == 2)
                            Flexible(
                              child: SwitchListTile(
                                  value: isSecurityEnabled,

                                  onChanged: (value) async {
                                    setState(() {
                                      isSecurityEnabled = value;
                                    });
                                    final pref =
                                        await SharedPreferences.getInstance();
                                    pref.setBool(Globals.SECURITY_ALLOWED,
                                        isSecurityEnabled);
                                  }),
                            )
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
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
}
