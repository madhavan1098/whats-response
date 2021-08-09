import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/widgets/commonCircularLoading.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';

const iOSLocalizedLabels = false;

class ContactListingPageScreen extends StatefulWidget {
  @override
  _ContactListingPageScreenState createState() =>
      _ContactListingPageScreenState();
}

class _ContactListingPageScreenState extends State<ContactListingPageScreen> {
  final box = GetStorage();
  List<Contact> _contacts;
  List<dynamic> data = List<dynamic>();
  var isLoading = true;

  @override
  void initState() {
    refreshContacts();
    super.initState();
  }

  Future<void> refreshContacts() async {
    // Load without thumbnails initially.
    var contacts = (await ContactsService.getContacts(
            withThumbnails: false, iOSLocalizedLabels: iOSLocalizedLabels))
        .toList();
    _contacts = contacts;
    print("_contacts: ${_contacts.length}");
    for (int i = 0; i < _contacts.length; i++) {
      Contact c = _contacts?.elementAt(i);
      bool value;
      if (fetchLocalSelectList("${c.displayName}").isEmpty) {
        value = false;
      } else {
        value = true;
      }
      Map temparray = {"${c.displayName}": value};
      data.add(temparray);
    }
    print("total data: ${data.length}");
    if (_contacts.length == data.length) {
      Future.delayed(Duration(seconds: 2), () {
        isLoading = false;
        setState(() {});
      });
    }
  }

  dynamic fetchLocalSelectList(list) {
    var selectedlist = box.read(Globals.SELECTEDLIST);
    print("local storage: $selectedlist");
    if (selectedlist != null) {
      var contain =
          selectedlist.where((element) => element["title"] == "$list");
      print("isselectedt: $contain");
      return contain;
    } else {
      return [];
    }
  }

  void updateContact() async {
    Contact ninja = _contacts
        .toList()
        .firstWhere((contact) => contact.familyName.startsWith("Ninja"));
    ninja.avatar = null;
    await ContactsService.updateContact(ninja);

    refreshContacts();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return CommonScaffold(
        backgroundColor: MyColors.white,
        child: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
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
                isLoading == true
                    ? Container(
                        height: MediaQuery.of(context).size.height - 160,
                        child: Center(child: LoadingWidget()),
                      )
                    : _contactList()
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
                      "My Contacts",
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

  Widget _contactList() {
    return Container(
        child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Contact c = _contacts?.elementAt(index);
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CheckboxListTile(
                activeColor: MyColors.primaryColor,
                title: Text("${_contacts[index].displayName}"),
                value: data[index]["${_contacts[index].displayName}"],
                onChanged: (bool value) {
                  //  showSnackbar("", "Please wait...",context);
                  data[index]["${c.displayName}"] = value;
                  if (value) {
                    if (box.read(Globals.SELECTEDLIST) == null) {
                      List<dynamic> selected_Data = List<dynamic>();
                      Map temparray = {
                        "title": "${c.displayName}",
                        "phoneNumber": "${c.phones.first.value}"
                      };
                      selected_Data.add(temparray);
                      box.write(Globals.SELECTEDLIST, selected_Data);
                    } else {
                      List<dynamic> selected_Data = List<dynamic>();
                      selected_Data = box.read(Globals.SELECTEDLIST);
                      Map temparray = {
                        "title": "${c.displayName}",
                        "phoneNumber": "${c.phones.first.value}"
                      };
                      selected_Data.add(temparray);
                      box.write(Globals.SELECTEDLIST, selected_Data);
                    }
                  } else {
                    List<dynamic> selected_Data = List<dynamic>();
                    selected_Data = box.read(Globals.SELECTEDLIST);
                    selected_Data.removeWhere(
                        (item) => item["title"] == "${c.displayName}");
                    box.write(Globals.SELECTEDLIST, selected_Data);
                  }

                  setState(() {});
                },
              )
            ],
          ),
        );
      },
      itemCount: _contacts.length,
    ));
  }
}
