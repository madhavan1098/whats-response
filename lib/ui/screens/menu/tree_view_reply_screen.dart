import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/controller/CommonController.dart';
import 'package:whatsauto/ui/screens/menu/tree_view_addon_reply_screen.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/widgets/alert_dialog.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';

class TreeViewReplyScreen extends StatefulWidget {
  final index;
  final treeList;
  const TreeViewReplyScreen({Key key, this.index, this.treeList}) : super(key: key);

  @override
  _TreeViewReplyScreenState createState() => _TreeViewReplyScreenState();
}

class _TreeViewReplyScreenState extends State<TreeViewReplyScreen> {
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
  List<FocusNode> focusNodes = [];
  TextEditingController firstcontroller = TextEditingController(text: '');

  @override
  void initState() {
    print("index: ${widget.index}");
    if (widget.treeList != null){

        print("addlist: ${widget.treeList}");
        print("addlist_box: ${CommonController.to.box.read('template_default')}");
        addList = widget.treeList;

      if (addList != null){
        plusbuttonList = Iterable<dynamic>.generate(addList.length).toList();
        textfieldVisibilityArray = List<bool>.generate(addList.length, (index) => true);
        isEditableArray = List<bool>.generate(addList.length, (index) => false);
        controllers = List<TextEditingController>.generate(addList.length, (index) => TextEditingController(text: addList[index]));
        focusNodes = List<FocusNode>.generate(addList.length, (int index) => FocusNode());
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
        if(widget.index == null){
          if (addList.length != 9){
            plusbuttonList.add("${addList.length + 1}");
            controllers.add(TextEditingController());
            focusNodes.add(FocusNode());
            isEditableArray.add(false);
            listMessageButtonsVisibilityArray.add(false);
            textfieldVisibilityArray.add(false);
          }
        }else{

        }

        print("plus:${focusNodes.length}");
        print("plus:${plusbuttonList.length}");
        print("controller:${controllers.length}");
        print("plus:${focusNodes.length}");
        print("editable:${isEditableArray.length}");
        print("buttonvisible:${listMessageButtonsVisibilityArray.length}");
      }

    }else{

       addList.add("Type your Message");
       plusbuttonList = Iterable<dynamic>.generate(2).toList();
       controllers = List<TextEditingController>.generate(2, (index) => TextEditingController());
       focusNodes = List<FocusNode>.generate(2, (int index) => FocusNode());
       isEditableArray =  List<bool>.generate(2, (index) => true);
       textfieldVisibilityArray = List<bool>.generate(2, (index) => true);
       listMessageButtonsVisibilityArray = List<bool>.generate(2, (index) => false);
       textfieldVisibilityArray[textfieldVisibilityArray.length-1] = false;
       isEditableArray[isEditableArray.length-1] = false;
       print("plus:${focusNodes.length}");
      print("plus:${plusbuttonList.length}");
      print("controller:${controllers.length}");
       print("plus:${focusNodes.length}");
      print("editable:${isEditableArray.length}");
      print("buttonvisible:${listMessageButtonsVisibilityArray.length}");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: ()  async {
      return widget.index == null ? showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return   AlertDialog(
            title: new Text("Exit"),
            content: new Text("Do you want to exit the Builder?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Yes"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ) : false;
    },
    child: CommonScaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()  {
         //   print("templatecount: ${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}");
            if (addList.isNotEmpty){
              // if (CommonController.to.box.read(Globals.TEMPLATE_COUNT) != null){
              //     int count = CommonController.to.box.read(Globals.TEMPLATE_COUNT);
              //     print("boxCount: $count");
              //     CommonController.to.box.write(Globals.TEMPLATE_COUNT, count+1);
              //     print("addlist: $addList}");
              //     print("count: ${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}");
              //     CommonController.to.box.write('template${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}', addList);
              // }else{
              //   CommonController.to.box.write(Globals.TEMPLATE_COUNT, 1);
              //   print("addlist: $addList}");
              //   CommonController.to.box.write('template${CommonController.to.box.read(Globals.TEMPLATE_COUNT)}', addList);
              // }
              if (textfieldVisibilityArray[textfieldVisibilityArray.length-1] == true){
                if (controllers[controllers.length-1].text != ""){
                 addList.add(controllers[controllers.length-1].text);
                }
              }
            //  CommonController.to.box.write('template_default', addList);
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
        ))));
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
                  widget.index == null ? showDialog(context: context, builder: (BuildContext context) {
                    return  AlertDialog(
                      title:  Text("Exit"),
                      content: new Text("Do you want to exit the Builder?"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Yes"),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                        new FlatButton(
                          child: new Text("No"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
                  ) : Navigator.of(context).pop();
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
                      "Menu Reply Tree View",
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
                                if (textfieldVisibilityArray[index] == false){
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
                                      focusNodes.add(FocusNode());
                                    }else{
                                      showSnackbar('', 'Fill in first field', context);
                                    }
                                  }else{
                                    print("length: ${addList.length}");
                                    print("plus: ${plusbuttonList.length}");
                                    print("controllers: ${controllers.length}");
                                    print("focusnode: ${focusNodes.length}");
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
                                      focusNodes.add(FocusNode());
                                    }
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
                                  focusNode: focusNodes[index],
                                  controller: controllers[index],
                                  enabled: isEditableArray[index] == true ? true : false,
                                  decoration: InputDecoration(
                                      hintText:
                                         index == 0 ? "Type your Message" : "Add List Message $index"),
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (value) {
                                   setState(() {
                                     print("index: $index");
                                     addList[index] = value;
                                     print("index: ${addList[index]}");
                                   });
                                  },
                                ),
                              ),
                              Visibility(
                                visible:listMessageButtonsVisibilityArray[index],
                                child: Row(
                                  mainAxisAlignment: index == 0 ?MainAxisAlignment.start  :MainAxisAlignment.spaceEvenly,
                                  children: [
                                   index == 0 ? SizedBox() : ElevatedButton.icon(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.green)),
                                        onPressed: () {
                                          var list;
                                          if (widget.index != null){
                                            list = ["Hello","How are you", "Any Queries", "Please provide your email","Please provide your Phonenumber","Provide your Feedback"];
                                          }else{
                                            list = CommonController.to.box.read('template_default_addon');
                                          }
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => TreeViewAddonReplyScreen(index: index,treeList: list,)),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: MyColors.white,
                                        ),
                                        label: Text(
                                          "ADD ON",
                                          style: TextStyle(
                                              color: MyColors.white,
                                              fontSize: 13),
                                        )),
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
                                            if (isEditableArray[index] == true) {
                                              print("isedit: ${isEditableArray}");
                                            Future.delayed(const Duration(milliseconds: 500), () {
                                              FocusScope.of(context).requestFocus(focusNodes[index]);
                                            });
                                            }
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
                                          focusNodes.removeAt(index);
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


