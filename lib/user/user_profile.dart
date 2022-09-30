import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/search_group.dart';
import 'package:test66/user/Edit_info.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/more_info.dart';
import 'package:test66/user/video_List.dart';

import 'ingroup.dart';
import 'models/groupinfo_module.dart';

class ProfileWidget extends StatefulWidget {
  final String? email;
  final bool fromnav;

  const ProfileWidget({
    Key? key,
    required this.email,
    required this.fromnav,
  }) : super(key: key);

  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  late int count = 10;
  late bool isLiked = true;
  late String text = "hiba";
  UserModel user = UserModel(
      name: "",
      phone: "",
      age: 0,
      lastonline: Lastonline(),
      online: false,
      image: "",
      email: "",
      password: "",
      level: 0,
      hight: 0,
      weight: 0,
      sex: "",
      country: "",
      type: "",
      musclesinjured: [],
      ingroup: "",
      groupid: "", );
  late UserModel user2;

  late GroupinfoModule group;

  @override
  void initState() {
    getuser2();
    getuser();

    print("hey");

    super.initState();
  }

  getuser() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.email)
        .snapshots()
        .listen((event) {
      setState(() {
        user = UserModel.fromJson(event.data()!);

          getgroup();


      });
    });
  }

  getuser2() async {
    final prefs = await SharedPreferences.getInstance();
 setState(() {
   user2 = UserModel.fromJson(json.decode(prefs.getString("user")!));
 });
  }

  getgroup() async {
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(user.groupid)
        .get()
        .then((value) {
     setState(() {
       group = GroupinfoModule.fromJson(value.data()!);
     });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "PROFILE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          actions: [],
          backgroundColor: Colors.black,
        ),
        body: Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color(0xfff60707)],
                    stops: [0.0, 1.0],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              clipper: getClipper(),
            ),
            Positioned(
                width: MediaQuery.of(context).size.width,
                top: MediaQuery.of(context).size.height / 11,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: NetworkImage(user.image),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),

                    SizedBox(height: 20.0),
                    Text(
                      user.name,
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      user.email,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Montserrat'),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      user.type,
                      style: TextStyle(
                          fontSize: 17.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Montserrat'),
                    ),
                    /*  SizedBox(height: 25.0),
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                'Edit Name',
                                style: TextStyle(color: Colors.white,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 25.0),*/
                    /*
                    Container(
                        height: 30.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.redAccent,
                          color: Colors.red,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                'Log out',
                                style: TextStyle(color: Colors.white,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        )),*/
                    SizedBox(height: 20.0),
                  Row(
                      children: [
                        user.ingroup=="yes"?Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 10, top: 20),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(Video_List(email: user.email,user: user2,group: group,));
                            },
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Container(
                                padding: EdgeInsets.only(top: 8, left: 18),
                                width: MediaQuery.of(context).size.width * 0.39,
                                height:
                                    MediaQuery.of(context).size.height * 0.051,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 2.5,
                                  ),
                                ),
                                child: Text(
                                  "VIEW VIDEOS",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        ):user.type=="player"&&user.email==user2.email?GestureDetector(
                          onTap: (){
                            Get.to(()=>search_group(fromnav: false));
                          },
                          child: Padding(
                            padding:const EdgeInsets.only(
                                left: 75, right: 10, top: 20),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Container(

                                width: MediaQuery.of(context).size.width * 0.59,
                                height:
                                MediaQuery.of(context).size.height * 0.051,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 2.5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Join Group now",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black54),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ):Container(),
                        user.ingroup == "yes"
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    print(group.toJson());
                                    Get.to(
                                        () =>
                                            ingroup(group: group, user: user),
                                        transition: Transition.downToUp,
                                        curve: Curves.ease,
                                        duration: Duration(seconds: 2));
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 0,
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 8, left: 17),
                                      width: MediaQuery.of(context).size.width *
                                          0.38,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.051,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                          color: Colors.black26,
                                          width: 2.5,
                                        ),
                                      ),
                                      child: Text(
                                        "VIEW GROUP",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Container(
                                padding: EdgeInsets.only(top: 8, left: 22),
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.051,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 2.5,
                                  ),
                                ),
                                child: Text(
                                  "LEVEL ${user.level}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => more_info(
                                  user: user,
                                ),
                                transition: Transition.zoom,
                                curve: Curves.easeOut,
                                duration: Duration(seconds: 2),
                              );
                            },
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Container(
                                padding: EdgeInsets.only(top: 8, left: 22),
                                width: MediaQuery.of(context).size.width * 0.36,
                                height:
                                    MediaQuery.of(context).size.height * 0.051,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: Colors.black26,
                                    width: 2.5,
                                  ),
                                ),
                                child: Text(
                                  "VIEW INFO",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black54),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            widget.email == user2.email
                ? Align(
                    alignment: AlignmentDirectional(-0.73, -0.52),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => Edit_info(user: user),
                            transition: Transition.fade,
                            curve: Curves.easeIn,
                            duration: Duration(seconds: 2));
                      },
                      child: Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ]),
                          child: Icon(
                            Icons.border_color,
                            color: Colors.white,
                            size: 24,
                          )),
                    ),
                  )
                : Container(),
          ],
        ));
  }

  _showBottomSheet() {
    Get.bottomSheet(
      Align(
        alignment: AlignmentDirectional(0.71, -2.7),
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  color: Color(0xFFBDBDBD),
                )
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(0),
              ),
              border: Border.all(
                color: Color(0xFFD6D6D6),
                width: 0,
              ),
            ),
            child: Stack(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 3.5);
    path.lineTo(size.width / 0.52, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
