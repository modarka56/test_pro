//dtatis:

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/admin/info_requests.dart';
import 'package:test66/admin/more_info_admin.dart';
import 'package:test66/user/models/Admin_module.dart';
import 'package:test66/user/models/group_module.dart';
import 'package:test66/user/models/groupinfo_module.dart';

import '../user/models/notfication_module.dart';

class ViewRequests extends StatefulWidget {
  const ViewRequests({Key? key}) : super(key: key);

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  List req = [];
  late AdminModule admin;

  @override
  void initState() {
    getrequsets();
    getuser();
    super.initState();
  }

  getuser() async {
    final prefs = await SharedPreferences.getInstance();
    admin = AdminModule.fromJson(json.decode(prefs.getString("admin")!));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: req.length,
      itemBuilder: (context, index) {
        GroupModule requ = new GroupModule.fromJson(req[index].data()!);
        return requ.status != "pendding"
            ? Container()
            : GestureDetector(
                onTap: () => _showBottomSheet(requ),
                child: Container(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        width: 100,
                        height: MediaQuery.of(context).size.height * 0.12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Color(0xFFD4D1D1),
                              spreadRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 7),
                            Material(
                              color: Colors.transparent,
                              elevation: 8,
                              shape: const CircleBorder(),
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9296f0),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                    width: 70,
                                    height: 70,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      requ.image!,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Align(
                                  alignment: AlignmentDirectional(-0.44, -0.72),
                                  child: Text(
                                    'Group Name : ${requ.name!}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-0.44, -0.72),
                                  child: Text(
                                    'Onwer Name : ${requ.onwername}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-0.48, -0.17),
                                  child: Text(
                                    'Email : ${requ.email}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  _showBottomSheet(GroupModule group) {
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
                InkWell(
                  onTap: () {
                    Get.to(()=>more_info_admin(email: group.email!));
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
                          "Coach Profile",
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
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.red,
                              size: 35,
                            ),
                            Text("cert and id"),
                          ],
                        ),
                        content: Container(
                          height: 450,
                          width: 200,
                          child: Column(
                            children: [
                              Image.network(
                                group.cert!,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,

                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Image.network(group.id!,
                                fit:BoxFit.fill,height:
                                  MediaQuery.of(context).size.height * 0.25,
                          ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text('ok')),
                        ],
                      ),
                    );
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
                          "View Certificate",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _displayTextInputDialog(context, group.email!);
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
                        savegroup(group);
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
    );
  }

  void getrequsets() async {
    await FirebaseFirestore.instance
        .collection("requstesG")
        .snapshots()
        .listen((event) {
      setState(() {
        req = event.docs;
      });
    });
  }

  void savegroup(GroupModule group) async {
    GroupinfoModule info = GroupinfoModule(
        name: group.name!,
        level: group.level!,
        onwername: group.onwername!,
        image: group.image!,
        bio: group.bio!,
        email: group.email!);
    var date = Timestamp.now().toDate();
    NotfiModule notf = NotfiModule(
        title: "Accept Group",
        date: date.toString(),
        message: "Group ${group.name} accpted",
        bywho: admin.name,
        type: "N");
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(group.name)
        .set(info.toJson())
        .then((value) {
      FirebaseFirestore.instance
          .collection("requstesG")
          .doc(group.email)
          .update({"status": "yes"}).then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(group.email)
            .update({"ingroup": "yes", "groupid": group.name}).then((value) {
          FirebaseFirestore.instance
              .collection("logs")
              .add(notf.toJson())
              .then((value) {
            print("ok");
            Get.back();
          });
        });
      });
    });
  }

  void Delete(String resaon, String email) async {
    var date = Timestamp.now().toDate();
    NotfiModule notf = NotfiModule(
        title: "Reject Group",
        date: date.toString(),
        message: resaon,
        bywho: "Admin",
        type: "N");
    await FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .collection("notification")
        .add(notf.toJson())
        .then((value) {
      notf.bywho = admin.name;
      FirebaseFirestore.instance
          .collection("logs")
          .add(notf.toJson())
          .then((value) {
        print("add");
        FirebaseFirestore.instance
            .collection("users")
            .doc(email)
            .update({"ingroup": "no"}).then((value) {
          FirebaseFirestore.instance
              .collection("requstesG")
              .doc(email)
              .update({"status": "no"}).then((value) {
            print("ok");
          });
        });
      });
    });
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
                    Delete(valueText!, email);
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
