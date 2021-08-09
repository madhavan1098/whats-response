import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/controller/CommonController.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/widgets/alert_dialog.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';

class TreeViewAddonReplyScreen extends StatefulWidget {
  final index;
  final treeList;
  const TreeViewAddonReplyScreen({Key key, this.index, this.treeList}) : super(key: key);

  @override
  _TreeViewAddonReplyScreenState createState() => _TreeViewAddonReplyScreenState();
}

class _TreeViewAddonReplyScreenState extends State<TreeViewAddonReplyScreen> {
  final _formKey = GlobalKey<FormState>();
  var docsOpen = false;
  var othertext = "Type your Message";
  var addList = [];
  var plusbuttonList = [];
  var isEditable = true;
  var isEditableArray = [];
  var addTextFieldList = [];
  var textfieldVisibilityArray = [];
  var messageButtonsVisibility = false;
  var listMessageButtonsVisibilityArray = [];

  List<TextEditingController> controllers = [];
  TextEditingController firstcontroller = TextEditingController(text: '');

  @override
  void initState() {

    if (widget.treeList != null){

        print("addlist: ${widget.treeList}");
        addList = widget.treeList;

      if (addList != null){
        plusbuttonList = Iterable<dynamic>.generate(addList.length).toList();
        textfieldVisibilityArray = List<bool>.generate(addList.length, (index) => true);
        isEditableArray = List<bool>.generate(addList.length, (index) => false);
        controllers = List<TextEditingController>.generate(addList.length, (index) => TextEditingController(text: addList[index]));
        listMessageButtonsVisibilityArray = List<bool>.generate(addList.length, (index) => true);
        if (textfieldVisibilityArray.length == 9){
          textfieldVisibilityArray[addList.length-1] = false;
        }

        if (listMessageButtonsVisibilityArray.length == 9){
          listMessageButtonsVisibilityArray[addList.length-1] = false;
        }

        if (plusbuttonList.length == addList.length && plusbuttonList.length == 9){
          listMessageButtonsVisibilityArray[listMessageButtonsVisibilityArray.length-1] = false;
          textfieldVisibilityArray[textfieldVisibilityArray.length-1] = false;
          if (addList.length == 9){
            addList.removeAt(addList.length-1);
          }

        }
        if(widget.index == null) {
          if (addList.length != 9) {
            plusbuttonList.add("${addList.length + 1}");
            controllers.add(TextEditingController());
            isEditableArray.add(false);
            listMessageButtonsVisibilityArray.add(false);
            textfieldVisibilityArray.add(false);
          }
        }
        print("plus:${plusbuttonList.length}");
        print("controller:${controllers.length}");
        print("editable:${isEditableArray.length}");
        print("buttonvisible:${listMessageButtonsVisibilityArray.length}");
      }

    }else{
      addList.add("Type your Message");
      //  addList.add("");
      plusbuttonList = Iterable<dynamic>.generate(2).toList();
      controllers = List<TextEditingController>.generate(2, (index) => TextEditingController());
      isEditableArray =  List<bool>.generate(2, (index) => true);
      textfieldVisibilityArray = List<bool>.generate(2, (index) => true);
      listMessageButtonsVisibilityArray = List<bool>.generate(2, (index) => false);
      textfieldVisibilityArray[textfieldVisibilityArray.length-1] = false;
      isEditableArray[isEditableArray.length-1] = false;
      print("plus:${plusbuttonList.length}");
      print("controller:${controllers.length}");
      print("editable:${isEditableArray.length}");
      print("buttonvisible:${listMessageButtonsVisibilityArray.length}");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
        //    print("templatecount: ${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}");
            if (addList.isNotEmpty){
              // if (CommonController.to.box.read(Globals.TEMPLATE_COUNT) != null){
              //   int count = CommonController.to.box.read(Globals.TEMPLATE_COUNT);
              //   print("boxCount: $count");
              //   CommonController.to.box.write(Globals.TEMPLATE_COUNT, count+1);
              //   print("addlist: $addList}");
              //   print("count: ${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}");
              //   CommonController.to.box.write('template_addon${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}', addList);
              // }else{
              //   CommonController.to.box.write(Globals.TEMPLATE_COUNT, 1);
              //   print("addlist: $addList}");
              //   CommonController.to.box.write('template_addon${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}', addList);
              // }
              if (textfieldVisibilityArray[textfieldVisibilityArray.length-1] == true){
                if (controllers[controllers.length-1].text != ""){
                  addList.add(controllers[controllers.length-1].text);
                }
              }
              CommonController.to.box.write('template_default_addon', addList);
            }
            Navigator.of(context).pop();
          },
          child: Icon(Icons.check),
          backgroundColor: MyColors.green,
        ),
        child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                  Navigator.pop(context, );
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
                      "Menu Reply Addon Tree View",
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
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            color: Color.fromARGB(255, 230, 227, 222),
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(shape: BoxShape.rectangle),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: addList.length,
                      itemBuilder: (context, index) {
                        return Align(
                            alignment: Alignment.centerRight,
                            child:    Container(
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: MyColors.green,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text( index == 0 ? "${addList[index]}"
                                      : "${index}. ${addList[index]}",
                                    style: TextStyle(color: MyColors.white),
                                  ),
                                ))  );
                      }),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height:20),
        Container(
          color: MyColors.white,
          padding: EdgeInsets.only(bottom: 30),
          child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: plusbuttonList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: index == 8 ? MyColors.green : MyColors.black),
                          child: IconButton(
                            icon: Icon(
                              index == 0 ? Icons.list : index == 8 ? Icons.check : Icons.add,
                              color: MyColors.white,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              print("index: $index");

                              setState(() {
                                if (index-1 == 0){
                                  if (addList[index-1] != "Type your Message"){
                                    addList.add("");
                                    listMessageButtonsVisibilityArray[index-1] = true;
                                    listMessageButtonsVisibilityArray.add(false);
                                    isEditableArray[index-1] = false;
                                    plusbuttonList.add('$index');
                                    textfieldVisibilityArray[index] = true;
                                    textfieldVisibilityArray.add(false);
                                    isEditableArray[index] = true;
                                    isEditableArray.add(true);
                                    print("length: ${addList.length}");
                                    controllers.add(TextEditingController());
                                  }else{
                                    showSnackbar('', 'Fill in first field', context);
                                  }
                                }else{
                                  print("length: ${addList.length}");
                                  print("plus: ${plusbuttonList.length}");
                                  print("controllers: ${controllers.length}");
                                  print("iseditable: ${isEditableArray.length}");
                                  print("textfield: ${textfieldVisibilityArray.length}");
                                  print("buttonvisible: ${listMessageButtonsVisibilityArray.length}");
                                  if (index == 8){
                                    listMessageButtonsVisibilityArray[index-1] = true;
                                    isEditableArray[index-1] = false;
                                  }else{
                                    addList.add("");
                                    listMessageButtonsVisibilityArray[index-1] = true;
                                    isEditableArray[index-1] = false;
                                    plusbuttonList.add('$index');
                                    textfieldVisibilityArray[index] = true;
                                    textfieldVisibilityArray.add(false);
                                    isEditableArray[index] = true;
                                    isEditableArray.add(true);
                                    listMessageButtonsVisibilityArray[index] = false;
                                    listMessageButtonsVisibilityArray.add(false);
                                    controllers.add(TextEditingController());
                                  }
                                }

                              });
                            },
                          ),
                          margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                          height: 40,
                        ),

                        textfieldVisibilityArray[index] == true ? Flexible(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 5, right: 20, top: 0, bottom: 10),
                                child: TextField(
                                  controller: controllers[index],
                                  enabled: isEditableArray[index] == true ? true : false,
                                  decoration: InputDecoration(
                                      hintText:
                                      index == 0 ? "Type your Message" : "Add List Message $index"),
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (value) {
                                    print("index: $index");
                                    addList[index] = value;
                                    print("index: ${addList[index]}");
                                  },
                                ),
                              ),
                              Visibility(
                                visible:listMessageButtonsVisibilityArray[index],
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // index == 0 ? SizedBox() : ElevatedButton.icon(
                                    //     style: ButtonStyle(
                                    //         backgroundColor:
                                    //         MaterialStateProperty.all(
                                    //             Colors.green)),
                                    //     onPressed: () {},
                                    //     icon: Icon(
                                    //       Icons.add,
                                    //       color: MyColors.white,
                                    //     ),
                                    //     label: Text(
                                    //       "ADD ON",
                                    //       style: TextStyle(
                                    //           color: MyColors.white,
                                    //           fontSize: 13),
                                    //     )),
                                    ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blueAccent)),
                                        onPressed: () {
                                          setState(() {
                                            isEditableArray[index] = !isEditableArray[index];
                                            addList[index] = '${controllers[index].text}';
                                            print("$addList");
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: MyColors.white,
                                        ),
                                        label: Text(
                                          isEditableArray[index] == true ? "DONE" : "EDIT" ,
                                          style: TextStyle(
                                              color: MyColors.white,
                                              fontSize: 13),
                                        )),
                                    SizedBox(width: 8,),
                                    index == 0 ? SizedBox() : ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          print("index: $index");
                                          addList.removeAt(index);
                                          plusbuttonList.removeAt(index);
                                          isEditableArray.removeAt(index);
                                          listMessageButtonsVisibilityArray.removeAt(index);
                                          textfieldVisibilityArray.removeAt(index);
                                          controllers.removeAt(index);
                                          print("index: ${addList.length}");
                                          print("index: ${plusbuttonList.length}");
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: MyColors.white,
                                      ),
                                      label: Text(
                                        "DELETE",
                                        style: TextStyle(
                                            color: MyColors.white, fontSize: 13),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.redAccent)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ) : SizedBox()
                      ],
                    ),
                    textfieldVisibilityArray[index] == true ? Row(
                      children: [
                        Container(margin: EdgeInsets.only(left: 35,top: 10),color: MyColors.grey ,height: 40,width: 0.8,),
                      ],
                    ) : SizedBox()
                    //SizedBox(height: 30,),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
