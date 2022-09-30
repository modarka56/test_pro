import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/user/add_program.dart';
import 'package:test66/user/group.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/models/join_request.dart';
import 'package:test66/user/user_profile.dart';
import 'package:test66/widget/drawer.dart';

import 'login_page.dart';
import 'models/group_module.dart';
import 'models/groupinfo_module.dart';

class ingroup extends StatefulWidget {
  final GroupinfoModule group;
  final UserModel user;

  const ingroup({Key? key, required this.group, required this.user})
      : super(key: key);

  @override
  State<ingroup> createState() => _ingroupState();
}

class _ingroupState extends State<ingroup> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List players = [];

  @override
  void initState() {
    getplayers();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Group",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        actions: [],
        backgroundColor: Colors.black,
      ),
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: AlignmentDirectional(-0.9, -0.27),
                child: Text(
                  widget.group.name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: widget.group.image.isEmpty?Image.asset("assets/Picture80.png", width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.28,
                  fit: BoxFit.cover,):Image.network(
                  widget.group.image,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.28,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.1, -0.59),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.94,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Color(0x50616161),
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '10K',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => GroupWidget(
                                      group: widget.group,
                                      user: widget.user,
                                    ));
                              },
                              child: Text(
                                'Posts',
                                style: TextStyle(
                                  color: Color(0xFF757575),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 2,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            players.length.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Players',
                              style: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 2,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Color(0xFFBDBDBD),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.group.level,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'Level',
                              style: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 310, 0, 75),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          child: Text(
                            widget.group.bio,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: Text(
                                'Group members',
                                style: TextStyle(
                                  color: Color(0xFF757575),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: SizedBox(
                                height: 150,
                                child: GridView.builder(
                                  padding: EdgeInsets.all(5.0),
                                  shrinkWrap: true,
                                  itemCount: players.length,
                                  itemBuilder: (context, index) {
                                    return members(
                                        group: widget.group,
                                        user: widget.user,
                                        players: players[index]);
                                  },
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5),
                                ),
                              ),
                            ),
                            widget.user.ingroup == "no"&&
                                    widget.user.type == "player"
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 40),
                                    child: InkWell(
                                      onTap: () {
                                        joingroup();
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10,
                                              color: Color(0x76757575),
                                              spreadRadius: 2,
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            'Join Group',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void joingroup() async {
    JoinreqModule req = JoinreqModule(
        title: "Join Group",
        message: "this player ${widget.user.name} want to join your group",
        phone: widget.user.phone,
        email: widget.user.email,
        playerimage: widget.user.image,
        type: "JR",
        date: Timestamp.now().toDate().toString(),
        level: widget.user.level.toString(),
        status: "no");
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.user.email)
          .update({"ingroup": "pendding"}).then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.group.email)
            .collection("notification")
            .add(req.toJson())
            .then((value) {
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
      });
    } catch (e) {}
  }

  void getplayers() async {
    try {
      await FirebaseFirestore.instance
          .collection("groups")
          .doc(widget.group.name)
          .collection("players")
          .snapshots()
          .listen((event) {
        setState(() {
          players = event.docs;
        });
      });
    } catch (e) {}
  }
}

class members extends StatefulWidget {
  final GroupinfoModule group;
  final UserModel user;
  final dynamic players;

  const members(
      {Key? key,
      required this.group,
      required this.user,
      required this.players})
      : super(key: key);

  @override
  State<members> createState() => _membersState();
}

class _membersState extends State<members> {
 List mu=[];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
      child: InkWell(
        onTap: _showBottomSheet,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.width * 0.18,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            widget.players.get("image"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _showBottomSheet() {
    var email=widget.players.get("email");
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.only(top: 4),
          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.07, 0.76),
                  child: InkWell(
                    onTap: () async{


                      await Get.to(
                        ProfileWidget(
                          email:email ,
                          fromnav: false,
                        ),
                        transition: Transition.cupertinoDialog,
                        curve: Curves.easeInOutSine,
                        duration: Duration(seconds: 2),
                      );
                     Get.back();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Color(0x76757575),
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'View Profile',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                widget.user.type == "coach"&& widget.user.email==widget.group.email
                    ? Align(
                        alignment: AlignmentDirectional(-0.05, 0.73),
                        child: InkWell(
                          onTap: () async{
                            await getinfo(widget.players.get("email"));
SharedPreferences perf=await SharedPreferences.getInstance();
await perf.setBool("cre", false);
                            showDialog(
                              context: context,
                              builder: (context)=>AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(Icons.warning_amber_rounded,color: Colors.red,
                                      size: 35,),
                                    Text(" Warning"),
                                  ],
                                ),
                                content: Container(
                                  height: 100,
                                  width: 200,
                                  child: Column(
                                    children: [
                                      Text("This player gave you injuries in :"),
                                      Container(
                                        height: 75,
                                        width:200,
                                        child: ListView.builder(itemCount:mu.length,itemBuilder: (context,index){
                                          return Text("${mu[index]}\n");
                                        }),
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(onPressed: (){
                                    Get.to(()=>add_program(email: widget.players.get("email")));
                                  },
                                      child: Text('ok')),
                                ],
                              ),
                            );
                            // print(widget.players.id);
                            // print(widget.user.email);
                            // print(widget.players.id);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Color(0x81757575),
                                  spreadRadius: 2,
                                )
                              ],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'Make program',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                widget.user.type == "coach"&&widget.user.email==widget.group.email
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                  alignment: AlignmentDirectional(-0.05, 1),
                  child: InkWell(
                      onTap: () {
                        remove();
                        // print(widget.players.id);
                        // print(widget.user.email);
                        // print(widget.players.id);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Color(0xFFA00707),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: Color(0x81757575),
                              spreadRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Remove the player',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFFFEBEE),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ),
                ),
                    )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void remove() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.players.get("email"))
        .update({"ingroup": "no", "groupid": ""}).then((value) {
      FirebaseFirestore.instance
          .collection("groups")
          .doc(widget.group.name)
          .collection("players")
          .doc(widget.players.id)
          .delete()
          .then((value) {
            Get.back();
      });
    });
  }
  getinfo(String email)async{

    await FirebaseFirestore.instance.collection("users").doc(email).get(
    ).then((value){

      setState(() {
        mu=value.get("musclesinjured");
      });
    });

  }

}
