import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/widgets/commonCircularLoading.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';



class MoreDetailScreen extends StatefulWidget {
  final List<String> content;
  final String title;
  MoreDetailScreen({this.content,this.title});
  @override
  _MoreDetailScreenState createState() =>
      _MoreDetailScreenState(listitems: content);
}

class _MoreDetailScreenState extends State<MoreDetailScreen> {
  final box = GetStorage();
  List<String> listitems = List<String>();
  _MoreDetailScreenState({this.listitems});
  var radioValue = 0;
  @override
  void initState() {

    super.initState();
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
                      height: 20,
                    ),
                    _radioList()
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
                  if (box.read(Globals.SELECTEDLIST) != null) {
                    box.write(Globals.CONTACT_SELECTION, true);
                  }
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
                      "${widget.title}",
                      style: TextStyle(
                          color: MyColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              Spacer(),
            ],
          ),
        ));
  }

  Widget _radioList() {
    return Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RadioListTile(
                    value: index,
                    activeColor: MyColors.green,
                    groupValue: radioValue,
                    onChanged: (ind) {
                      setState(() {
                        print("$ind");
                        radioValue = ind;
                      });
                    },
                    title: Text("${listitems[index]}")

                  ),
                ],
              ),
            );
          },
          itemCount: listitems.length,
        ));
  }
}
