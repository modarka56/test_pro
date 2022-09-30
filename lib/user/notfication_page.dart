import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/user/models/join_request.dart';
import 'package:test66/user/models/notfication_module.dart';
import 'package:test66/user/user_profile.dart';

import 'models/User_model.dart';

class notification_page extends StatefulWidget {
  const notification_page({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  State<notification_page> createState() => _notification_pageState();
}

class _notification_pageState extends State<notification_page> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List noti = [];
   UserModel? user ;
  @override
  void initState() {
    getnoti();
    getuser();
    super.initState();
  }
getuser() async {
    final prefs=await SharedPreferences.getInstance();
    user=UserModel.fromJson(jsonDecode(prefs.getString("user")!));
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        title: Text(
          'notification ',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),

        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 0, 10, 0),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: noti.length,
              itemBuilder: (BuildContext context, int index) {

                if (noti[index].get("type") == "N") {
                  NotfiModule not = NotfiModule.fromJson(noti[index].data()!);
                  return Normalreq(
                    noti: not,
                  );
                } else {
                  JoinreqModule not =
                      JoinreqModule.fromJson(noti[index].data()!);
                  return Joinnot(
                    req: not,
                    user: user!,
                    id: noti[index].id,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void getnoti() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.email)
        .collection("notification")
        .snapshots()
        .listen((event) {
      setState(() {
        noti = event.docs;

      });
    });
  }
}

class Joinnot extends StatefulWidget {
  final JoinreqModule req;
  final UserModel user;
  final String id;

  const Joinnot({Key? key, required this.req, required this.user, required this.id}) : super(key: key);

  @override
  State<Joinnot> createState() => _JoinnotState();
}

class _JoinnotState extends State<Joinnot> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.req.date!);
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            widget.req.playerimage!,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: InkWell(
              onTap: () {
                widget.req.status=="no"?_showBottomSheet(widget.req):null;
              },
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF06292),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 15, 10, 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 13),
                        child: Text(
                          widget.req.title!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Text(
                          "From: ${widget.req.email!}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 13),
                        child: Text(
                          widget.req.message!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Text(
                        "Date: ${date.year}/${date.month}/${date.day}  at ${date.hour}:${date.minute}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showBottomSheet(JoinreqModule req) {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.only(top: 4),
          height: 200,
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(ProfileWidget(email: req.email!,fromnav: false,),
                          transition: Transition.fade,
                          curve: Curves.easeInOutSine,
                          duration: Duration(seconds: 1),);
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.25,
                            vertical: 15),
                        width: 345,
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(7, 2, 0, 0),
                          child: Text(
                            "Player Profile",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _displayTextInputDialog(context, req.email!);
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Container(
                            width: 100,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // savegroup(group);
                          saveplayer();
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Container(
                            width: 100,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Accepte",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController _textFieldController = TextEditingController();
  String? valueText;

  Future<void> _displayTextInputDialog(
      BuildContext context, String email) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('TextField in Dialog'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Text Field in Dialog"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    Delete(valueText!,email );
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  void saveplayer() async{
    try{
      print(widget.user.groupid);
      await FirebaseFirestore.instance.collection("users").doc(widget.req.email).update({"ingroup":"yes","groupid":widget.user.groupid}).then((value){
        FirebaseFirestore.instance.collection("users").doc(widget.user.email).collection("notification").doc(widget.id).update({"status":"yes"}).then((value) {
          FirebaseFirestore.instance.collection("groups").doc(widget.user.groupid).collection("players").add({"email":widget.req.email,"image":widget.req.playerimage}).then((value) {
            print("okey");
            Get.back();
          });

        });
      });
    }catch(e){
      
    }
  }

  void Delete(String s, String email) async{
    NotfiModule not= NotfiModule(
      title: "Reject join",
        bywho: widget.user.email,
        message: s,
        date: Timestamp.now().toDate().toString(),
        type:"N");
    await FirebaseFirestore.instance.collection("users").doc(widget.req.email).update({"ingroup":"no"}).then((value){
      FirebaseFirestore.instance.collection("users").doc(widget.user.email).collection("notification").doc(widget.id).update({"status":"yes"}).then((value){
        FirebaseFirestore.instance.collection("users").doc(widget.req.email).collection("notification").add(not.toJson()).then((value){
          Get.back();
        });
      });
    });
  }
}

class Normalreq extends StatefulWidget {
  final NotfiModule noti;

  const Normalreq({Key? key, required this.noti}) : super(key: key);

  @override
  State<Normalreq> createState() => _NormalreqState();
}

class _NormalreqState extends State<Normalreq> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.noti.date!);
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            'https://picsum.photos/seed/190/600',
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.yellowAccent.shade200,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 15, 10, 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 13),
                      child: Text(
                        widget.noti.title!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                      child: Text(
                        "From: ${widget.noti.bywho!}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 13),
                      child: Text(
                        widget.noti.message!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Text(
                      " Date: ${date.year}/${date.month}/${date.day}  at ${date.hour}:${date.minute}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
