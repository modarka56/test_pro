//DB: لا يوجد إدخال فقط الإستعلام عن وجود الحساب و صحة الباسوورد
/*
مهام مضر
التحقق من وجود الحساب في قاعدة البيانات
التحقق من صحة الباسوورد
إعادة تعيين الباسوورد
تفعيل زر Login
 */


import 'dart:async';
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/Creat_group.dart';
import 'package:test66/user/home_page.dart';
import 'package:test66/user/models/Admin_module.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/signup_page.dart';
import 'package:test66/user/widget/widgets.dart';

import '../admin/home_page.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

final _formKey = new GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool emailvalid = false;

class _Login extends State<Login> {

  late bool passwordVisibility;
  bool isprocces = false;
  bool isloading = false;
  var mypassword, myemail;
  final passwordEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();


  void vaildation() {
    print("hello");
    final _form = _formKey.currentState;
    final x;
    if (_form!.validate()) {
      print("Yes******************");
    } else {
      x = _form.validate();
      print(x);
      print(emailEditingController.text.toString());
      print(passwordEditingController.text.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: isloading ? Center(child: CircularProgressIndicator(),) : SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional(-0.99, 0),
              child: Material(
                color: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(40),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.55,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.68,
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
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(40),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(30, 50, 0, 0),
                    child: Text(
                      'Login',
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
            Align(
              alignment: AlignmentDirectional(0.86, -0.6),
              child: InkWell(
                onTap: () {
                  Get.to(SignUpWidget());
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF9E9E9E),
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Align(
                alignment: AlignmentDirectional(0.12, 0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.93,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.35,
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
                    alignment: AlignmentDirectional(-0.15, 0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 1.17),
                          child: Image.asset(
                            'assets/Picture8.png',
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(15, 20, 15, 0),
                          child: Form(

                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InputField(
                                  obscureText: false,
                                  controller: emailEditingController,
                                  hint: 'Email',

                                  icon: Icon(Icons.email,),
                                  validator: (value) {
                                    if (value == "") {
                                      return "Please Fill Email";
                                    } else if (regExp.hasMatch(value!)) {
                                      return "Email Is Invaild";
                                    }
                                    return "";
                                  },
                                  onChanged: (value) {
                                    if (chackemail(
                                        emailEditingController.text) &&
                                        emailEditingController.text != null) {
                                      setState(() {
                                        emailvalid = true;
                                      });
                                    } else {
                                      setState(() {
                                        emailvalid = false;
                                      });
                                    }
                                  },

                                ),
                                InputField(
                                  controller: passwordEditingController,
                                  hint: 'Password',
                                  icon: Icon(Icons.vpn_key,),
                                  validator: (value) {
                                    if (value == "") {
                                      return "Please Fill Password";
                                    }
                                    return "ok";
                                  },
                                  suffixIcon: InkWell(
                                    onTap: () =>
                                        setState(
                                              () =>
                                          passwordVisibility =
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
                                Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                                  child: Text(
                                    'forget Password ?',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF37474F),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.04, 1.22),
                          child: GestureDetector(
                            onTap: () {
                              if (emailEditingController.text
                                  .trim()
                                  .isEmpty ||
                                  !emailvalid) {
                                showdaialogg(context, "email");
                              } else {
                                if (passwordEditingController.text.length <=
                                    6) {
                                  showdaialogg(context, "password");
                                } else {
                                  Signin();
                                }
                              }
                            },
                            child: Material(
                              color: Colors.transparent,
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
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
                                  child: !isprocces ? Text(
                                    'Login',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ) : Text(
                                    'Loading....',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
    );
  }

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
          message:
          'the password must be more than 6 ',
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
          message:
          'the email is incorrect ',
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        isprocces = !isprocces;
      });
    }
  }

  Signin() async {
    DateTime date = Timestamp.now().toDate();
    print("heyyyy");
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailEditingController.text.trim().toLowerCase(),
          password: passwordEditingController.text).then((value) {
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Great Welcome',
            message:
            "Welcome back ${value.user!.email}",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        FirebaseFirestore.instance.collection("users")
            .doc(value.user!.email)
            .get()
            .then((res) async {
          if (res.get("type") == "admin" || res.get("type") == "subadmin") {
            AdminModule admin = AdminModule.fromJson(res.data()!);
            await prefs.setString("admin", json.encode(admin));
            Get.off(() => HomePage(admin: admin,),
              transition: Transition.leftToRight,
              curve: Curves.bounceInOut,
              duration: Duration(seconds: 2),);
            setState(() {
              isloading = false;
            });
          } else {
            UserModel user = UserModel.fromJson(res.data()!);
            if (user.lastonline.day !=
                value.user!.metadata.lastSignInTime!.day) {
              Lastonline login = Lastonline(
                  year: value.user!.metadata.lastSignInTime!.year,
                  month: value.user!.metadata.lastSignInTime!.month,
                  day: value.user!.metadata.lastSignInTime!.day);
              await FirebaseFirestore.instance.collection("users").doc(
                  user.email).update({"lastonline":login.toJson()}).then((value)async{
                if (user.type == "player") {
                  await FirebaseFirestore.instance.collection("users").doc(
                      user.email).collection("dp").get().then((value) async {
                    for (var i in value.docs) {
                      await i.reference.delete();
                    }
                  });
                  await FirebaseFirestore.instance.collection("users").doc(
                      user.email).collection("co").get().then((value) async {
                    for (var i in value.docs) {
                      await i.reference.delete();
                    }
                  });
                } else {
                  await FirebaseFirestore.instance.collection("users").doc(
                      user.email).collection("dp").get().then((value) async {
                    for (var i in value.docs) {
                      await i.reference.delete();
                    }
                  });
                }
              });

            }
            print(user.toJson());
            await prefs.setString("user", json.encode(user));
            await prefs.setStringList("pro", []);
            UserModel user1 = UserModel.fromJson(
                json.decode(prefs.getString("user")!));
            print("2" + "${user1.toJson()}");
            Get.off(() => HomePageWidget(id: 1,), transition: Transition.leftToRight,
              curve: Curves.bounceInOut,
              duration: Duration(seconds: 3),);
            setState(() {
              isloading = false;
            });
          }
        });
      });

      // if (snapshot.docs[0].get("type") == "student") {
      //   if (snapshot.docs[0].get("type") == "student" &&
      //       snapshot.docs[0].get("state") == false) {
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (context) => waiting_page()));
      //   } else {
      //     if (snapshot.docs[0].get("type") == "student" &&
      //         snapshot.docs[0].get("state") == true) {
      //       Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(
      //               builder: (context) => main_student_profilepage()));
      //     }
      //   }
      // } else {
      //   if (snapshot.docs[0].get("type") == "coach") {
      //     if (reqsnapshot.docs[0].get("state") == true &&
      //         snapshot.docs[0].get("type") == "coach") {
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => main_coach_page()));
      //     } else {
      //       if (snapshot.docs[0].get("type") == "coach" &&
      //           reqsnapshot.docs[0].get("state") == false) {
      //         Navigator.pushReplacement(context,
      //             MaterialPageRoute(builder: (context) => waiting_page()));
      //       }
      //     }
      //   } else {
      //     Navigator.pushReplacement(
      //         context, MaterialPageRoute(builder: (context) => admin_page()));
      //   }
      // }
    } catch (e) {
      setState(() {
        isloading = false;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(e.toString()),
              actions: [
                MaterialButton(
                  elevation: 5.0,
                  child: Text("ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  bool chackemail(String email) {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)
        ? true
        : false;
  }
}
