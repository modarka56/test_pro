import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test66/user/models/Admin_module.dart';

class AddSubadmin extends StatefulWidget {
  final List users;

  const AddSubadmin({Key? key, required this.users}) : super(key: key);

  @override
  State<AddSubadmin> createState() => _AddSubadmin();
}

class _AddSubadmin extends State<AddSubadmin> {
  late String dropDownValue1;
  late String dropDownValue2;
  late TextEditingController textController1;
  late TextEditingController textController3;
  late TextEditingController textController2;
  late TextEditingController textController4;
  late String radioButtonValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    print(widget.users);
  }
@override
  void dispose() {
   textController4.dispose();
   textController3.dispose();
   textController2.dispose();
   textController1.dispose();
    super.dispose();
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
          'Add SubAdmin',
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
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 5),
                    child: Text(
                      'Subadmin name',
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
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Enter the name  subAdmin ',
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
                        color: Colors.black),
                  ),
                  Divider(
                    indent: 5,
                    endIndent: 0,
                    color: Color(0xFFBDBDBD),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                    child: Text(
                      'Email',
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
                    decoration: InputDecoration(
                      hintText: 'enter the Emile sub admin ',
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
                        Icons.email,
                      ),
                    ),
                    style: TextStyle(),
                  ),
                  Divider(
                    indent: 5,
                    endIndent: 0,
                    color: Color(0xFFBDBDBD),
                  ),
                  TextFormField(
                    controller: textController2,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'enter the password',
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
                        Icons.password,
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
                    controller: textController4,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'enter the phone sub admin',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 90),
                    child: InkWell(
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
                              colors: [Color(0xFF450101), Color(0xFFE20505)],
                              stops: [0, 0.8],
                              begin: AlignmentDirectional(1, 0.34),
                              end: AlignmentDirectional(-1, -0.34),
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(60, 14, 0, 0),
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
                        onTap: () {
                          validtions();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validtions() {
    if ((textController1.text.isEmpty || textController1.text.trim() == " ") ||
        (textController2.text.isEmpty || textController2.text.trim() == " ") ||
        (textController3.text.isEmpty || textController3.text.trim() == " ") ||
        (textController4.text.isEmpty || textController4.text.trim() == " ")
    ) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh Snap',
          message: "fileds requeris fill up please",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      bool emailuse = !searchemail(textController3.text.trim());
      bool usernameuse = !searchusername(textController1.text.trim());
      if (emailuse ||
          usernameuse) {
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Snap',
            message: usernameuse&& emailuse ? "email and username already in use" :emailuse
                ? "email already in use"
                : "username already in use",
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        save();
      }

    }
  }

  searchemail(String email) {
    for (int i = 0; i < widget.users.length; i++) {
      if (widget.users[i].get("email") == email) {
        return false;
      }
    }
    return true;
  }

  searchusername(String username) {
    for (int i = 0; i < widget.users.length; i++) {
      if (widget.users[i].get("name") == username) {
        return false;
      }
    }
    return true;
  }

  void save() async {
    try {
      AdminModule subadmin = AdminModule(name: textController1.text.trim(),
          email: textController3.text.trim(),
          password: textController2.text,
          phone: textController4.text.trim(),type: "subadmin");
      // print(subadmin.toJson());

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: textController3.text.trim(), password: textController2.text)
          .then((value) {
        AdminModule subadmin = AdminModule(name: textController1.text.trim(),
            email: textController3.text.trim(),
            password: textController2.text,
            phone: textController4.text.trim(),type: "subadmin");
        FirebaseFirestore.instance.collection("users").doc(subadmin.email).set(subadmin.toJson()).then((value){
          var snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Great',
              message: "you have add data :)",
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Get.back();
        });
      });
    } catch (e) {

    }
  }
}
