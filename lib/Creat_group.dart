import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/user/login_page.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/models/group_module.dart';

class CreateGroupWidget extends StatefulWidget {
  const CreateGroupWidget({Key? key}) : super(key: key);

  @override
  _CreateGroupWidgetState createState() => _CreateGroupWidgetState();
}

class _CreateGroupWidgetState extends State<CreateGroupWidget> {
  late String dropDownValue1;
  late String dropDownValue2;
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  bool _isBackPressedOrTouchedOutSide = false, _isDropDownOpened = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late File image;
  late File image1;
  late File image2;
  bool isdone=true;
  bool isdone1=true;
  List groups=[];

  String imageString =
      "https://firebasestorage.googleapis.com/v0/b/t-gym-58401.appspot.com/o/no.jpg?alt=media&token=59246c51-34e6-4641-a7b9-1e4d5f4e73b9";

  late String imagepath;
  late String certpath;
  late String idpath;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    dropDownValue1 = "";
    dropDownValue2 = "";
    imagepath="";
    getuser();
    getgroups();
  }

  getuser() async {
    final prefs = await SharedPreferences.getInstance();
    user = UserModel.fromJson(json.decode(prefs.getString("user")!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          'create group',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: getImage,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.03, 0.01),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(imageString),
                              radius: 100,
                            )
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.98, 0.81),
                            child: Icon(
                              Icons.camera_rounded,
                              color: Color(0xFF212121),
                              size: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.group_rounded,
                          color: Color(0xFF757575),
                          size: 30,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: TextFormField(
                              controller: textController1,
                              onChanged: (_) {},
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'enter the name group',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF212121),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF212121),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF616161),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          CupertinoIcons.info_circle_fill,
                          color: Color(0xFF757575),
                          size: 30,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: TextFormField(
                              maxLines: 5,
                              controller: textController4,
                              onChanged: (_) {},
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'enter bio',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF212121),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF212121),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF616161),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(44, 30, 0, 0),
                    child: Wrap(
                      children: [
                        Container(
                          height: 70,
                          width: 150,
                          child: AwesomeDropDown(
                              isPanDown: true,
                              dropDownList: [
                                "0",
                                "1",
                                "2",
                                "3",
                                "4",
                                "5",
                                "6",
                                "7",
                                "8"
                              ],
                              dropDownBorderRadius: 2,
                              onDropDownItemClick: (item) {
                                setState(() {
                                  dropDownValue2 = item;
                                });
                              },
                              isBackPressedOrTouchedOutSide:
                                  _isBackPressedOrTouchedOutSide,
                              selectedItem: dropDownValue2,
                              dropStateChanged: (isOpened) {
                                _isDropDownOpened = isOpened;
                                if (!isOpened) {
                                  _isBackPressedOrTouchedOutSide = false;
                                }
                              }),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                          child: Container(
                            height: 70,
                            width: 150,
                            child: AwesomeDropDown(
                              dropDownList: ["5", "10"],
                              dropDownBorderRadius: 2,
                              onDropDownItemClick: (item) {
                                setState(() {
                                  dropDownValue1 = item;
                                });
                              },
                              selectedItem: dropDownValue1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.branding_watermark_outlined,
                          color: Color(0xFF757575),
                          size: 30,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: TextFormField(
                              controller: textController2,
                              onTap: getImage1,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                               enabled: isdone,
                                hintText: 'Training Certificate...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF303030),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF303030),
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF616161),
                                fontSize: 14,
                              ),
                              keyboardType: TextInputType.url,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: Color(0xFF757575),
                          size: 33,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: TextFormField(
                              controller: textController3,
                              onTap: getImage2,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabled: isdone1,
                                hintText: 'ID card',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF303030),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF303030),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 35, 0, 25),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        maximumSize: Size(200, 200),
                        fixedSize: Size(150, 50),
                        shape:   RoundedRectangleBorder(
                      borderRadius:  BorderRadius.circular(20.0),
                    ),
                        minimumSize: Size(50,50),
                        textStyle: TextStyle(color: Colors.black,fontSize: 20)
                      ),
                      onPressed: () {
                        validation();
                      },
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validation() {
    if ((textController1.text.trim().isEmpty ||
        textController2.text.trim().isEmpty ||
        textController3.text.trim().isEmpty)||!searchusername(textController1.text))  {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh Snap',
          message: " All fields are requireor the name is already in use",
          contentType: ContentType.warning,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      save();
    }
  }

  Future getImage() async {
    // Get image from gallery.
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(pickedfile!.path);
    _uploadImageToFirebase(image, "profile");
  }

  Future getImage1() async {
    // Get image from gallery.
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image1 = File(pickedfile!.path);
    _uploadImageToFirebase(image1, "cert");
  }

  Future getImage2() async {
    // Get image from gallery.
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image2 = File(pickedfile!.path);
    _uploadImageToFirebase(image2, "id");
  }

  Future<void> _uploadImageToFirebase(File image, String type) async {
    if (type == "profile") {
      try {
        // Make random image name.
        int randomNumber = Random().nextInt(100000);
        String imageLocation =
            'images/profiles/${user.email}/img${randomNumber}.jpg';
        // String imageLocation = 'video/video${randomNumber}.mp4';

        // Upload image to firebase.
        final Reference = FirebaseStorage.instance.ref().child(imageLocation);

        final uploadTask =
            Reference.putFile(image).whenComplete(() => print("uploadcomplet"));
        await uploadTask
            .whenComplete(() => _addPathToDatabase(imageLocation, type));
      } catch (e) {
        print(e);
      }
    } else {
      if (type == "cert") {
        try {
          // Make random image name.
          int randomNumber = Random().nextInt(100000);
          String imageLocation =
              'images/certs/${user.email}/cert${randomNumber}.jpg';
          // String imageLocation = 'video/video${randomNumber}.mp4';

          // Upload image to firebase.
          final Reference = FirebaseStorage.instance.ref().child(imageLocation);

          final uploadTask = Reference.putFile(image)
              .whenComplete(() => print("uploadcomplet"));
          await uploadTask
              .whenComplete(() => _addPathToDatabase(imageLocation, type));
        } catch (e) {
          print(e);
        }
      } else {
        try {
          // Make random image name.
          int randomNumber = Random().nextInt(100000);
          String imageLocation =
              'images/ids/${user.email}/id${randomNumber}.jpg';
          // String imageLocation = 'video/video${randomNumber}.mp4';

          // Upload image to firebase.
          final Reference = FirebaseStorage.instance.ref().child(imageLocation);

          final uploadTask = Reference.putFile(image)
              .whenComplete(() => print("uploadcomplet"));
          await uploadTask
              .whenComplete(() => _addPathToDatabase(imageLocation, type));
        } catch (e) {
          print(e);
        }
      }
    }
  }

  Future<void> _addPathToDatabase(String text, String type) async {
    if (type == "profile") {
      try {
        // Get image URL from firebase
        final ref = FirebaseStorage.instance.ref().child(text);
        imageString = await ref.getDownloadURL();

        // Add location and url to database

        // await FirebaseFirestore.instance
        //     .collection("images")
        //     .doc(user.email)
        //     .collection("listimages").doc(user.email).set({'url':imageString , 'location':text});
        // await FirebaseFirestore.instance.collection("group").doc(user.email).update({'image':imageString});

        setState(() {
          imagepath = imageString;
          // user.image=imageString;
        });
      } catch (e) {
        print(e);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.toString()),
              );
            });
      }
    } else {
      if (type == "cert") {
        try {
          // Get image URL from firebase
          final ref = FirebaseStorage.instance.ref().child(text);
          certpath = await ref.getDownloadURL();

          // Add location and url to database

          // await FirebaseFirestore.instance
          //     .collection("images")
          //     .doc(user.email)
          //     .collection("listimages").doc(user.email).set({'url':imageString , 'location':text});
          // await FirebaseFirestore.instance.collection("users").doc(user.email).update({'image':imageString});

          setState(() {
            textController2.text = certpath;
            // user.image=imageString;
            isdone=false;
          });
        } catch (e) {
          print(e);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(e.toString()),
                );
              });
        }
      } else {
        try {
          // Get image URL from firebase
          final ref = FirebaseStorage.instance.ref().child(text);
          idpath = await ref.getDownloadURL();

          // Add location and url to database

          // await FirebaseFirestore.instance
          //     .collection("images")
          //     .doc(user.email)
          //     .collection("listimages").doc(user.email).set({'url':imageString , 'location':text});
          // await FirebaseFirestore.instance.collection("users").doc(user.email).update({'image':imageString});

          setState(() {
            textController3.text = idpath;
            isdone1=false;
            // user.image=imageString;
          });
        } catch (e) {
          print(e);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(e.toString()),
                );
              });
        }
      }
    }
  }

  save() async {
    try {
      GroupModule group = GroupModule(
          name: textController1.text.trim().toLowerCase(),
          image: imagepath,
          cert: certpath,
          id: idpath,
          level: dropDownValue2==""?"0":dropDownValue2,
          numberofplayers: dropDownValue1==""?"5":dropDownValue1,
      onwername: user.name,
      email: user.email,
      phone: user.phone,
      bio: textController4.text,
      status:"pendding");
      await FirebaseFirestore.instance
          .collection("requstesG")
          .doc(user.email)
          .set(group.toJson())
          .then((value) async{
            await FirebaseFirestore.instance.collection("users").doc(user.email).update({"ingroup":"pendding"});
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Great',
            message:
            "The Request has been send please stand by now you must login again to update your data   ",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.off(()=>Login());
      });
    } catch (e) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh Snap',
          message: "Somthing wrong ${e}",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void getgroups() async{
    await FirebaseFirestore.instance.collection("groups").snapshots().listen((event) {
      setState(() {
        groups=event.docs;
      });
    });
  }
  searchusername(String username) {
    for (int i = 0; i < groups.length; i++) {
      if (groups[i].get("name") == username) {
        return false;
      }
    }
    return true;
  }
}
