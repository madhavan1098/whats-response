import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';

import 'contactList.dart';

class ContactSelectionPageScreen extends StatefulWidget {
  @override
  _ContactSelectionPageScreenState createState() =>
      _ContactSelectionPageScreenState();
}

class _ContactSelectionPageScreenState
    extends State<ContactSelectionPageScreen> {
  final box = GetStorage();

  @override
  void initState() {
    _askPermissions(null);
    super.initState();
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                box.read(Globals.CONTACT_SELECTION) == false ||
                        box.read(Globals.CONTACT_SELECTION) == null
                    ? Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/svg/chat-4.svg",
                              color: MyColors.primaryColor,
                              height: 35,
                              width: 35,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "Click to create a list of contacts to send messages as auto-reply",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: MyColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ContactListingPageScreen()),
                                ).then((value) {
                                  if (value) {
                                    setState(() {
                                      print("setting state");
                                    });
                                  }
                                });
                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: MyColors.primaryColor),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: MyColors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Selected Contacts",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: MyColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          contactList()
                        ],
                      )
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
                      "Contact Selection",
                      style: TextStyle(
                          color: MyColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              Spacer(),
              box.read(Globals.CONTACT_SELECTION) == true
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactListingPageScreen()),
                        ).then((value) {
                          if (value) {
                            setState(() {
                              print("setting state");
                            });
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5, right: 10),
                        height: 60,
                        child: Icon(
                          Icons.add,
                          color: MyColors.white,
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ));
  }

  Widget contactList() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: box.read(Globals.SELECTEDLIST).length,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Column(
              children: [
                Container(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: MyColors.grey),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${box.read(Globals.SELECTEDLIST)[index]["title"]}",
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                                //  overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${box.read(Globals.SELECTEDLIST)[index]["phoneNumber"]}",
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: MyColors.primaryColor),
                            //  overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(
                    thickness: 0.8,
                    color: MyColors.liteGrey,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
