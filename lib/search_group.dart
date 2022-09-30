import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/user/group.dart';
import 'package:test66/user/ingroup.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/models/group_module.dart';
import 'package:test66/user/models/groupinfo_module.dart';

class search_group extends StatefulWidget {
  final bool fromnav;
  const search_group({Key? key, required this.fromnav}) : super(key: key);

  @override
  State<search_group> createState() => _search_groupState();
}

class _search_groupState extends State<search_group> {
  late TextEditingController searchController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List groups = [];
  List Results = [];
  late UserModel user;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
    getgroups();
    getuser();
  }


  getuser() async {
    final prefs = await SharedPreferences.getInstance();
    user = UserModel.fromJson(jsonDecode(prefs.getString("user")!));
  }
@override
  void dispose() {
  searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF060606),
        automaticallyImplyLeading: true,
        title: Text(
          'Search',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFFFFEBEE),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),

      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 5),
                      child: TextFormField(
                        controller: searchController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'search group',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF262D34),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF262D34),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF95A1AC),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF95A1AC),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: Results.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        GroupinfoModule group =
                            GroupinfoModule.fromJson(Results[index].data());
                        // print(group);
                        return groupcontainer(
                          snapshot: group,
                          user: user,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getgroups() {
    FirebaseFirestore.instance.collection("groups").snapshots().listen((event) {
      setState(() {
        groups = event.docs;
        searchResultsList();
      });
    });
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (searchController.text != "") {
      for (var i in groups) {
        var title = returnname(i);

        if (title.trim().toLowerCase().contains(searchController.text.toLowerCase())) {
          showResults.add(i);
        }
      }
    } else {
      for (var i in groups) showResults.add(i);
    }
    setState(() {
      Results = showResults;
    });
  }

  returnname(DocumentSnapshot snapshot) {
    return snapshot.get("name");
  }
}

class groupcontainer extends StatefulWidget {
  final GroupinfoModule snapshot;
  final UserModel user;

  const groupcontainer({Key? key, required this.snapshot, required this.user})
      : super(key: key);

  @override
  State<groupcontainer> createState() => _groupcontainerState();
}

class _groupcontainerState extends State<groupcontainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 12),
      child: Material(
        color: Colors.transparent,
        elevation: 11,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: widget.snapshot.image.isEmpty?Image.asset(
               "assets/Picture80.png",
              ).image:Image.network(
                widget.snapshot.image,
              ).image,
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${widget.snapshot.name}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFFFEBEE),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Level: ${widget.snapshot.level}",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFFFEBEE),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: InkWell(
                        onTap: () {

                            Get.to(() => ingroup(group: widget.snapshot,user: widget.user,),
                                transition: Transition.cupertino,
                                curve: Curves.easeInCirc,
                                duration: Duration(seconds: 2));

                        // if(widget.user.level < int.parse(widget.snapshot.level)){
                        //   var snackBar = SnackBar(
                        //     elevation: 0,
                        //     behavior: SnackBarBehavior.floating,
                        //     backgroundColor: Colors.transparent,
                        //     content: AwesomeSnackbarContent(
                        //       title: 'Sorry',
                        //       message:
                        //       "Your Level is not Enough For this group",
                        //       contentType: ContentType.warning,
                        //     ),
                        //   );
                        //
                        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // }
                        },
                        child: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
