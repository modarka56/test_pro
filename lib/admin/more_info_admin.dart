import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test66/user/models/User_model.dart';

class more_info_admin extends StatefulWidget {
  final String email;
  const more_info_admin({Key? key, required this.email}) : super(key: key);

  @override
  State<more_info_admin> createState() => _more_info_adminState();
}

class _more_info_adminState extends State<more_info_admin> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  UserModel? user;

  @override
  void initState() {
    getuser();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
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
          'more info',
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 5),
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_sharp,
                      color: Colors.black,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Text(
                        user!.name,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  indent: 5,
                  endIndent: 20,
                  color: Color(0xFFBDBDBD),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 0),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF616161),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.black,
                        size: 25,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                        child: Text(
                         user!.email,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 5,
                  endIndent: 20,
                  color: Color(0xFFBDBDBD),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                  child: Text(
                    'Phone',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.phone_rounded,
                      color: Colors.black,
                      size: 25,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Text(
                        user!.phone,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  indent: 5,
                  endIndent: 20,
                  color: Color(0xFFBDBDBD),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 8),
                  child: Text(
                    'Gender',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                      child: Text(
                        user!.sex,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  indent: 5,
                  endIndent: 20,
                  color: Color(0xFFBDBDBD),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                  child: Text(
                    'Date of Birth',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.cake_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Text(
                        user!.age.toString(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  indent: 5,
                  endIndent: 20,
                  color: Color(0xFF9E9E9E),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 100, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                              child: Text(
                                'Height',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF757575),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              "${user!.hight} cm",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Text(
                              'Weight',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF757575),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            '${user!.weight} kg',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 5,
                  endIndent: 20,
                  color: Color(0xFFBDBDBD),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
                  child: Text(
                    'Injuries',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF757575),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: SizedBox(
                    height: 150,
                    child: ListView.builder(
                        itemCount: user!.musclesinjured.length,
                        itemBuilder: (context, index) => Text(
                          "${user!.musclesinjured[index]} \n ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getuser() async{
     FirebaseFirestore.instance.collection("users").doc(widget.email).snapshots().listen((event) {
      setState(() {
       user=UserModel.fromJson(event.data()!);
      });
    });
  }
}
