import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:whatsauto/helper/notification_event_handler.dart';
import 'package:whatsauto/model/message_model.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/commonStyles.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';
import 'package:whatsauto/ui/theme/widgets/logo.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final _formKey = GlobalKey<FormState>();
  var noOfReplySent = 0;
  bool today = true;
  bool yesterday = false;
  bool other = false;
  AndroidNotificationListener _notifications;
  StreamSubscription<NotificationEvent> _subscription;
  List<NotificationEvent> _log = [];
  var whatsappNotificationCount = 0;
  var whatsappBusinessNotificationCount = 0;
  var gmailBusinessNotificationCount = 0;
  List<MessageModel> chatArray_today = [];
  List<MessageModel> chatArray_yesterday = [];
  List<MessageModel> chatArray_other = [];
  static const notificationNativePlatform =
      const MethodChannel('whatsauto.flutter.dev/notification');

  @override
  void initState() {
    openAndroidNotificationSettings();
    print("today: ${chatArray_today}");
    print("yesterday: ${chatArray_yesterday}");
    print("other: ${chatArray_other}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _appBar(_formKey),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Text(
                          "Reply Sent",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins_Bold",
                              fontSize: 26),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "$noOfReplySent",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins_Bold",
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/other/whatsapp.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Whatsapp : ",
                              style: labelTextStyle,
                            ),
                            Text("$whatsappNotificationCount"),
                            SizedBox(
                              width: 15,
                            ),
                            Image.asset(
                              "assets/images/other/whatsapp-2.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text("Whatsapp Business : ", style: labelTextStyle),
                            Text("$whatsappBusinessNotificationCount"),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/other/gmail.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Gmail : ",
                              style: labelTextStyle,
                            ),
                            Text("$gmailBusinessNotificationCount"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MyColors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 6.0,
                            offset: Offset(2.0, 4.0), //(x,y)
                            spreadRadius: 1),
                      ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            today = true;
                            yesterday = false;
                            other = false;
                          });
                        },
                        child: today
                            ? Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: MyColors.grey),
                                child: Center(
                                  child: Text(
                                    "Today",
                                    style: TextStyle(color: MyColors.white),
                                  ),
                                ),
                              )
                            : Text("Today")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            today = false;
                            yesterday = true;
                            other = false;
                          });
                        },
                        child: yesterday
                            ? Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: MyColors.grey),
                                child: Center(
                                  child: Text(
                                    "Yesterday",
                                    style: TextStyle(color: MyColors.white),
                                  ),
                                ),
                              )
                            : Text("Yesterday")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            today = false;
                            yesterday = false;
                            other = true;
                          });
                        },
                        child: other
                            ? Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: MyColors.grey),
                                child: Center(
                                  child: Text(
                                    "Other",
                                    style: TextStyle(color: MyColors.white),
                                  ),
                                ),
                              )
                            : Text("Other")),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.download,
                            color: MyColors.green,
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: today
                        ? chatArray_today.length
                        : yesterday
                            ? chatArray_yesterday.length
                            : other
                                ? chatArray_other.length
                                : null,
                    itemBuilder: (context, index) {
                      MessageModel content;
                      if (today) {
                        content = chatArray_today[index];
                      } else if (yesterday) {
                        content = chatArray_yesterday[index];
                      } else {
                        content = chatArray_other[index];
                      }
                      return GestureDetector(
                          onTap: () async {},
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 25, top: 20),
                                height: 60,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                      ),
                                      child: Center(
                                        child: Text(
                                            "${content.message.characters.first.toUpperCase()}",
                                            style: TextStyle(
                                                color: MyColors.white)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${content.message}"),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              color: MyColors.grey,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${content.time}",
                                              style: TextStyle(
                                                  color: MyColors.grey),
                                            )
                                          ],
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  thickness: 0.8,
                                ),
                              )
                            ],
                          ));
                    }),
              )
            ],
          ),
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

  /**@author Tijo Thomas
   * @use native method to call notification settings
   * */
  Future<void> openAndroidNotificationSettings() async {
    notificationNativePlatform.invokeMethod('openNotification');

//start listening to notifications
    _notifications = new AndroidNotificationListener();
    try {
      _subscription = _notifications.notificationStream.listen((onData) {
        var jsonData = json.decode(onData.packageExtra);
        print("data from notification $jsonData");
        if (jsonData["android.text"] != null) {
          switch (onData.packageName) {
            case "com.whatsapp":
              {
                setState(() {
                  whatsappNotificationCount++;
                  chatArray_today.add(MessageModel(
                      message: onData.packageMessage,
                      time: DateFormat('hh:mm a').format(onData.timeStamp)));
                });
                break;
              }
            case "com.whatsapp.w4b":
              {
                setState(() {
                  whatsappBusinessNotificationCount++;
                  chatArray_today.add(MessageModel(
                      message: onData.packageMessage,
                      time: DateFormat('hh:mm a').format(onData.timeStamp)));
                });
                break;
              }
            case "com.google.android.gm":
              {
                setState(() {
                  gmailBusinessNotificationCount++;
                  chatArray_today.add(MessageModel(
                      message: onData.packageMessage,
                      time: DateFormat('hh:mm a').format(onData.timeStamp),
                      name: jsonData["Chat"]));
                });
                break;
              }
          }
        }
      });
    } on NotificationException catch (exception) {
      print(exception);
    }
  }

  void onData(NotificationEvent event) {
    setState(() {
      _log.add(event);
    });
    print(event.toString());
  }

  ///for stopping the notification listener _subscription.cancel() can be used
}
