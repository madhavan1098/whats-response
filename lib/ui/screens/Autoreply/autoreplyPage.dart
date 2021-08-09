import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:whatsauto/config/globals.dart';
import 'package:whatsauto/ui/theme/MyColors.dart';
import 'package:whatsauto/ui/theme/widgets/alert_dialog.dart';
import 'package:whatsauto/ui/theme/widgets/common_scaffold.dart';
//import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class AutoreplyPageScreen extends StatefulWidget {
  @override
  _AutoreplyPageScreenState createState() => _AutoreplyPageScreenState();
}

class _AutoreplyPageScreenState extends State<AutoreplyPageScreen> {
  bool status = false;
  bool isEmojiShowing = false;
  File imageFile1;
  File pdfFile1;
  final box = GetStorage();
  TextEditingController firstNameController = TextEditingController();

  void _pickImage1() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    imageFile1 = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile1 != null) {
      setState(() {
        print("image: $imageFile1}");
      });
    }
  }

  void _pickPDF() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      pdfFile1 = File(result.files.single.path);
      if (pdfFile1 != null)
        setState(() {
          print("PDF LOCAL STORAGE : $pdfFile1}");
        });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    if (box.read(Globals.MESSAGE) != null) {
      firstNameController.text = '${box.read(Globals.MESSAGE)}';
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
              children: [_appBar(_formKey), mainView()],
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
                      "Instant Reply",
                      style: TextStyle(
                          color: MyColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              Spacer(),
              Container(
                height: 60,
                child: InkWell(
                    onTap: () {
                      if (firstNameController.text == '') {
                        showSnackbar('', 'Kindly Enter your message', context);
                      } else {
                        showSnackbar('', 'Message saved successfully', context);
                        box.write(Globals.MESSAGE, firstNameController.text);
                      }
                    },
                    child: Image.asset(
                      'assets/images/other/save.png',
                      height: 20,
                      width: 20,
                    )),
              )
            ],
          ),
        ));
  }

  Widget mainView() {
    return Container(
        height: MediaQuery.of(context).size.height - 120,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, bottom: 10),
                    child: Text(
                      "Auto Reply Message",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: MyColors.black),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: TextFormField(
                  controller: firstNameController,
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF737E7E),
                      fontWeight: FontWeight.w200),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 16, 10, 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: MyColors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: MyColors.primaryColor),
                    ),
                    hintText: "Enter your Message",
                    hintStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF737E7E),
                        fontWeight: FontWeight.w100),
                    // errorText: "",
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: MyColors.red),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: MyColors.red),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _pickImage1();
                      },
                      child: Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: MyColors.yellowColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        _pickPDF();
                      },
                      child: Icon(
                        Icons.picture_as_pdf,
                        size: 20,
                        color: MyColors.yellowColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isEmojiShowing = !isEmojiShowing;
                        });
                      },
                      child: Icon(
                        Icons.emoji_emotions,
                        size: 20,
                        color: MyColors.yellowColor,
                      ),
                    ),
                    Spacer(),
                    // InkWell(
                    //   onTap: (){
                    //     if (firstNameController.text != ''){
                    //
                    //     }
                    //   },
                    //   child:  Container(
                    //     child: Center(child: Icon(Icons.check,color: MyColors.white,),),height: 30,width: 50,
                    //     decoration: BoxDecoration(color: MyColors.primaryColor,borderRadius: BorderRadius.circular(40)),),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Auto Reply",
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlutterSwitch(
                      activeColor: MyColors.primaryColor,
                      width: 45.0,
                      height: 25.0,
                      valueFontSize: 12.0,
                      toggleSize: 18.0,
                      value: status,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              imageFile1 != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("${imageFile1.path.split('/').last}"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        imageFile1 = null;
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: MyColors.red,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullScreenPage(
                                                imagefile: imageFile1,
                                              )),
                                    );
                                  },
                                  child: Text(
                                    'Show',
                                    style: TextStyle(
                                        color: MyColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ))
                            ],
                          )
                        ],
                      ))
                  : SizedBox(),
              SizedBox(
                height: 10,
              ),
              pdfFile1 != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 300,
                                    child: Text(
                                      "${pdfFile1.path.split('/').last}",
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 4,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        pdfFile1 = null;
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: MyColors.red,
                                      size: 20,
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                /*    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfViewScreen(
                                                pdfFile: pdfFile1,
                                              )),
                                    );*/
                                    OpenFile.open(pdfFile1.path);
                                  },
                                  child: Text(
                                    'Show',
                                    style: TextStyle(
                                        color: MyColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ))
                            ],
                          )
                        ],
                      ))
                  : SizedBox(),
              /* EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  // Do something when emoji is tapped
                },
                onBackspacePressed: () {
                  // Backspace-Button tapped logic
                  // Remove this line to also remove the button in the UI
                },
                config: Config(
                    columns: 7,
                    emojiSizeMax: 32.0,
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    initCategory: Category.RECENT,
                    bgColor: Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    progressIndicatorColor: Colors.blue,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    noRecentsText: "No Recents",
                    noRecentsStyle:
                    const TextStyle(fontSize: 20, color: Colors.black26),
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL
                ),
              )*/
            ],
          ),
        ));
  }
}

class FullScreenPage extends StatelessWidget {
  final File imagefile;

  FullScreenPage({Key key, this.imagefile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child: Image.file(imagefile),
      ),
    );
  }
}

class PdfViewScreen extends StatelessWidget {
  final File pdfFile;

  const PdfViewScreen({Key key, this.pdfFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
