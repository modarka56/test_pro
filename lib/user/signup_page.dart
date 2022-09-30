//DB: Name - Phone number - Email - Password
/*
مهام مضر
التاكد من أن الحساب غير موجود في قاعدة البيانات
في حال لم يكن موجود التأكد من صحة وجود الايميل
تفعيل زر Sign up

 */
import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test66/user/login_page.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/userdataset.dart';
import 'package:test66/user/widget/widgets.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

final _formKey = new GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);

class _SignUpWidgetState extends State<SignUpWidget> {
  late bool passwordVisibility;
  var myusername, mypassword, myemail;
  bool isprocces = false;
  late QuerySnapshot searchsnap;
  final userNameEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();

  void vaildation() {
    final _form = _formKey.currentState;
    final x;
    if (_form!.validate()) {
      print("Yes******************");
      if (searchemail(emailEditingController.text) &&
          searchusername(userNameEditingController.text) &&
          searchphone(phoneEditingController.text)) {
        sginup();
      } else {
        showdaialogg(context, "username");
      }
    } else {
      x = _form.validate();
      print(x);
      print("No*******************");
      print(userNameEditingController.text.toString());
      print(phoneEditingController.text.toString());
      print(emailEditingController.text.toString());
      print(passwordEditingController.text.toString());
    }
  }

  @override
  void initState() {
    getusersforsearch();
    passwordVisibility = false;
    super.initState();
  }

  getusersforsearch() {
    FirebaseFirestore.instance.collection("users").get().then((value) {
      setState(() {
        searchsnap = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(
                  -0.86,
                  -0.65,
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(Login());
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF9E9E9E),
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.98, 0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: MediaQuery.of(context).size.height * 0.68,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Color(0xFF616161),
                          spreadRadius: 1,
                        )
                      ],
                      gradient: LinearGradient(
                        colors: [Color(0xFF150101), Color(0xFFD50404)],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0.14, -1),
                        end: AlignmentDirectional(-0.14, 1),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 10, 0),
                      child: Text(
                        'Sign up',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFFE0E0E0),
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Align(
                  alignment: AlignmentDirectional(0.02, 0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.93,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: Color(0x7E303030),
                            spreadRadius: 1,
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: AlignmentDirectional(-0.152, 0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 1.14),
                            child: Image.asset(
                              'assets/Picture8.png',
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.04, 1.12),
                            child: GestureDetector(
                              onTap: () {
                                vaildation();
                              },
                              child: Material(
                                color: Colors.transparent,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
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
                                        50, 14, 0, 0),
                                    child: Text(
                                      'Sign up',
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
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InputField(
                                  obscureText: false,
                                  controller: userNameEditingController,
                                  hint: 'Name',
                                  icon: Icon(
                                    Icons.person,
                                  ),
                                  validator: (value) {
                                    if (value == "") {
                                      return "Please Fill UserName";
                                    } else if (value!.length < 6) {
                                      return "UserName Is Too Short";
                                    }
                                  },
                                ),
                                InputField(
                                  obscureText: false,
                                  controller: phoneEditingController,
                                  hint: 'phone number',
                                  icon: Icon(
                                    Icons.phone_rounded,
                                  ),
                                  validator: (value) {
                                    if (value == "") {
                                      return "Please Fill Phone Number ";
                                    } else if (value!.length < 10) {
                                      return "Phone Number Must Be 10";
                                    }
                                  },
                                ),
                                InputField(
                                  obscureText: false,
                                  controller: emailEditingController,
                                  hint: 'Email',
                                  icon: Icon(
                                    Icons.email,
                                  ),
                                  validator: (value) {
                                    if (value == "") {
                                      return "Please Fill Email";
                                    } else if (!regExp.hasMatch(value!)) {
                                      return "Email Is Invaild";
                                    }
                                  },
                                ),
                                InputField(
                                  controller: passwordEditingController,
                                  hint: 'Password',
                                  icon: Icon(
                                    Icons.vpn_key,
                                  ),
                                  validator: (value) {
                                    if (value == "") {
                                      return "Please Fill Password";
                                    } else if (value!.length < 8) {
                                      return "Password Is Too Short";
                                    }
                                  },
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Color(0xFF757575),
                                      size: 22,
                                    ),
                                  ),
                                  obscureText: !passwordVisibility,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // bool chackemail(String email) {
  //   return RegExp(
  //       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(email)
  //       ? true
  //       : false;
  // }
  showdaialogg(BuildContext context, String error) {
    setState(() {
      isprocces = !isprocces;
    });

    if (error == "password") {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: 'the password must be more than 6 ',
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isprocces = !isprocces;
      });
    } else {
      if (error == "email") {
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'the email is incorrect ',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          isprocces = !isprocces;
        });
      } else {
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap!',
            message: 'the email or phone or username already in use ',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          isprocces = !isprocces;
        });
      }
    }
  }

  searchemail(String email) {
    for (int i = 0; i < searchsnap.docs.length; i++) {
      if (searchsnap.docs[i].get("email") == email) {
        return false;
      }
    }
    return true;
  }

  searchusername(String username) {
    for (int i = 0; i < searchsnap.docs.length; i++) {
      if (searchsnap.docs[i].get("name") == username) {
        return false;
      }
    }
    return true;
  }

  searchphone(String phone) {
    for (int i = 0; i < searchsnap.docs.length; i++) {
      if (searchsnap.docs[i].get("phone") == phone) {
        return false;
      }
    }
    return true;
  }

  void sginup() async {
    UserModel user = new UserModel(
      name: userNameEditingController.text.trim(),
      email: emailEditingController.text.trim().toLowerCase(),
      password: passwordEditingController.text,
      phone: phoneEditingController.text.trim(),
      age: 0,
      lastonline: new Lastonline(day: 0, month: 0, year: 0),
      level: 0,
      hight: 0,
      weight: 0,
      sex: "",
      country: "",
      type: "",
      groupid: '',
      musclesinjured: [],
      image: '',
      online: true,
      ingroup: '',
    );
    try {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Great Welcome',
          message: "Just Few steps to become a master  ",
          contentType: ContentType.help,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Timer(Duration(seconds: 3), () {
        Get.off(
            () => Userdataset(
                  username: userNameEditingController.text,
                  phone: phoneEditingController.text,
                  email: emailEditingController.text,
                  password: passwordEditingController.text,
                ),
            transition: Transition.downToUp,
            curve: Curves.bounceIn,
            duration: Duration(seconds: 2));
      });
    } catch (e) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh Snapp',
          message: "somthing wrong please  try again ,${e}  ",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
