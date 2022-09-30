import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test66/user/models/User_model.dart';

import 'login_page.dart';

class Edit_info extends StatefulWidget {
  final UserModel user;

  const Edit_info({Key? key, required this.user}) : super(key: key);

  @override
  State<Edit_info> createState() => _Edit_infoState();
}

class _Edit_infoState extends State<Edit_info> {

  late String dropDownValue1;
  late String dropDownValue2;
  var country1;
  String imagepath = "";
  bool ismod = false;
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  late TextEditingController textController5;
  late TextEditingController textController6;
  late String radioButtonValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    textController5 = TextEditingController();
    textController6 = TextEditingController();
    initetext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'Edit info',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 125),
                    child: Stack(
                        children: [
                          Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          imagepath.isEmpty
                                              ? widget.user.image
                                              : imagepath),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(75.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 7.0, color: Colors.black)
                                  ])),
                          Align(
                            alignment: AlignmentDirectional(-0.28, 0.24),
                            child: GestureDetector(
                              onTap: getImage,
                              child: Container(
                                  width: 35.0,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(75.0)),
                                      boxShadow: [
                                        BoxShadow(blurRadius: 7.0,
                                            color: Colors.black)
                                      ]),
                                  child: Icon(Icons.photo_camera,
                                    color: Colors.white,
                                    size: 24,
                                  )),
                            ),
                          ),
                        ]
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 5),
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: textController1,
                    onChanged: (s) {
                      if (s != widget.user.name) {
                        ismod = true;
                      }
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'enter your name ',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      prefixIcon: Icon(
                        Icons.person,
                        size: 28,
                      ),
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black
                    ),
                  ),
                  Divider(
                    indent: 5,
                    endIndent: 0,
                    color: Color(0xFFBDBDBD),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: textController3,
                    obscureText: false,
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        countryListTheme: CountryListThemeData(
                          flagSize: 25,
                          backgroundColor: Colors.white,
                          textStyle:
                          TextStyle(fontSize: 16, color: Colors.blueGrey),
                          bottomSheetHeight: 500,
                          // Optional. Country list modal height
                          //Optional. Sets the border radius for the bottomsheet.
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          //Optional. Styles the search field.
                          inputDecoration: InputDecoration(
                            labelText: 'Search',
                            hintText: 'Start typing to search',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                const Color(0xFF8C98A8).withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                        onSelect: (Country country) =>
                            setState(() {
                              country1 =
                              "${country.flagEmoji} ${country.countryCode}";
                              textController3.text=country1;
                            }),
                      );
                    },
                    onChanged: (s) {
                      if (s != widget.user.country) {
                        ismod = true;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'enter your country',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.public,
                      ),
                    ),
                    style: TextStyle(),
                  ),
                  Divider(
                    indent: 5,
                    endIndent: 0,
                    color: Color(0xFFBDBDBD),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                    child: Text(
                      'Phone',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: textController5,
                    keyboardType: TextInputType.number,
                    onChanged: (s) {
                      if (s != widget.user.phone) {
                        ismod = true;
                      }
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'enter your phone',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.phone_rounded,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    indent: 5,
                    endIndent: 0,
                    color: Color(0xFFBDBDBD),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                    child: Text(
                      'Age',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: textController2,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    onChanged: (s) {
                      if (s != widget.user.age.toString()) {
                        ismod = true;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'enter your age',

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.cake,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    indent: 5,
                    endIndent: 0,
                    color: Color(0xFF9E9E9E),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                    child: Text(
                      'Height',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: textController4,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    onChanged: (s) {
                      if (s != widget.user.hight.toString()) {
                        ismod = true;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'enter your height',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.height,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    indent: 5,
                    endIndent: 0,
                    color: Color(0xFFBDBDBD),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                    child: Text(
                      'Weight',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: textController6,
                    onChanged: (s) {
                      if (s != widget.user.weight.toString()) {
                        ismod = true;
                      }
                    },
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'enter your weight',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Container(

                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.4,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.06,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF450101),
                                  Color(0xFFE20505)
                                ],
                                stops: [0, 0.8],
                                begin: AlignmentDirectional(1, 0.34),
                                end: AlignmentDirectional(-1, -0.34),
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  60, 14, 0, 0),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (ismod) {
                          save();
                        } else {
                          Get.back();
                        }
                      }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    // Get image from gallery.
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    File videoo = File(pickedfile!.path);
    _uploadvideoToFirebase(videoo);
  }

  Future<void> _uploadvideoToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'images/profiles/${widget.user
          .email}/img${randomNumber}.jpg';
      // String imageLocation = 'video/video${randomNumber}.mp4';

      // Upload image to firebase.
      final Reference = FirebaseStorage.instance.ref().child(imageLocation);

      final uploadTask =
      Reference.putFile(image).whenComplete(() => print("uploadcomplet"));
      await uploadTask
          .whenComplete(() => _addPathvideoToDatabase(imageLocation));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addPathvideoToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage.instance.ref().child(text);
      String imagestring = await ref.getDownloadURL();

      // Add location and url to database

      // await FirebaseFirestore.instance
      //     .collection("images")
      //     .doc(user.email)
      //     .collection("listimages").doc(user.email).set({'url':imageString , 'location':text});
      // await FirebaseFirestore.instance.collection("group").doc(user.email).update({'image':imageString});

      setState(() {
        imagepath = imagestring;
        ismod = true;
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

  void initetext() {
    textController1.text = widget.user.name;
    textController2.text = widget.user.age.toString();
    textController3.text = widget.user.country;
    textController4.text = widget.user.hight.toString();
    textController5.text = widget.user.phone;
    textController6.text = widget.user.weight.toString();
  }

  void save() async {
    UserModel user = UserModel(name: textController1.text,
        phone: textController5.text,
        age: int.parse(textController2.text),
        lastonline: Lastonline(year: Timestamp
            .now()
            .toDate()
            .year, month: Timestamp
            .now()
            .toDate()
            .month, day: Timestamp
            .now()
            .toDate()
            .day),
        online: true,
        image: imagepath.isEmpty?widget.user.image:imagepath,
        email: widget.user.email,
        password: widget.user.password,
        level: widget.user.level,
        hight
            : int.parse(textController4.text),
        weight: int.parse(textController6.text),
        sex: widget.user.sex,
        country: textController3.text,
        type: widget.user.type,
        musclesinjured: widget.user.musclesinjured,
        ingroup: widget.user.ingroup,
        groupid: widget.user.groupid, );
    await
    FirebaseFirestore.instance.collection("users")
        .doc(widget.user.email)
        .update(user.toJson()).then((value) {
          FirebaseAuth.instance.signOut();
          var snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Login Requier',
              message: "to update your data please log in again",
              contentType: ContentType.warning,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Timer(Duration(seconds: 2), () => Get.off(() => Login()));
    });
  }
}
