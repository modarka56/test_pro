import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/admin/info_requests.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:test66/admin/view_exercises.dart';
import 'package:test66/admin/view_requests.dart';
import 'package:test66/user/models/Admin_module.dart';
import 'package:test66/widget/admin_drwaer.dart';
import 'package:test66/widget/drawer.dart';
class HomePage extends StatefulWidget{
  final AdminModule admin;

  HomePage({Key? key, required this.admin}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // getadmin()async{
  //   SharedPreferences pref=await SharedPreferences.getInstance();
  //  setState(() {
  //    admin=AdminModule.fromJson(jsonDecode( pref.getString("admin")!));
  //  });
  // }
  
  
  @override
  void initState() {
   // getadmin();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) =>DefaultTabController(
      length:2,
      child:Scaffold(
        backgroundColor: Colors.black,
drawer: admin_drwaer(user: widget.admin,),
        appBar: AppBar(
          backgroundColor:Color(0xFFFAFAFA),
          elevation: 0,
          iconTheme: IconThemeData(
              color: Colors.black,
          size: 30
          ),
          bottom: TabBar(
            padding: EdgeInsets.only(left: 15,right: 15,bottom: 10),
            unselectedLabelColor: Colors.black87,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.deepPurple,Colors.black87]
                ),
                borderRadius: BorderRadius.circular(50),
                color:Colors.black
            ),
            tabs: [
              Tab(
                  child:Align(
                      alignment: Alignment.center,
                      child:Text('View Requests'))),
              Tab(
                  child:Align(
                      alignment: Alignment.center,
                      child:Text('view Exercise'))),
            ],
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xFFFAFAFA),
                width:  MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,),
                  child: Stack(
                      children:[
                        TabBarView(
                        children: [
                        ViewRequests(),
                        ViewExercises(admin: widget.admin,),
                        //  ViewRequests(),
                         // ViewExercise(),
                        ],
                      ),
                      ]      ),
                  ),
              ),
               SizedBox(height: 10),
               Text("The Gym is your responsibility",
                 style: TextStyle(
                   color: Colors.white,
                   fontWeight: FontWeight.w500,
                   fontSize: 16,
                 ),
               ),
               Text("Hello Admin. You can view request information by clicking on it " ,style: TextStyle(
                 color: Colors.white,
                  fontWeight: FontWeight.w400,
                 fontSize: 13,
               ),)
            ],
          ),
        ),
      ));
}