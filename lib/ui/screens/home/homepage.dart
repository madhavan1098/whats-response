import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsauto/ui/screens/Autoreply/autoreplyPage.dart';
import 'package:whatsauto/ui/screens/menu/menu_reply_screen.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';
import 'package:whatsauto/ui/theme/widgets/logo.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var featureListing = [
    {
      "title": "Instant Reply",
      "subtitle": "Set message for auto reply",
      "image": "assets/images/other/call-center.png"
    },
    {
      "title": "Menu Reply",
      "subtitle": "Set a chatbot based auto reply",
      "image": "assets/images/other/reply.png"
    }
  ];

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
                featureList()
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

  Widget featureList() {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: featureListing.length,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AutoreplyPageScreen()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuReplyScreen()),
                );
              }
            },
            child: Column(
              children: [
                Container(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "${featureListing[index]["image"]}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${featureListing[index]["title"]}",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24,
                                  ),
                                  //  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${featureListing[index]["subtitle"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFA2A2A2),
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
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
