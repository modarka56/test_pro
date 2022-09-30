import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../components/button_widget.dart';
import 'add_program.dart';
import 'models/User_model.dart';

class exr_deatils extends StatefulWidget {
  final String UrlVideo;
  final String nameExercise;
  final int level;
  final String details;
  final String id;
  final String email;
  final bool program;
  const exr_deatils({Key? key, required this.UrlVideo, required this.nameExercise, required this.level, required this.details, required this.id, required this.email, required this.program}) : super(key: key);

  @override
  State<exr_deatils> createState() => _exr_deatilsState();
}

class _exr_deatilsState extends State<exr_deatils> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<void> _initializeVideoPlayerFuture;
  late VideoPlayerController controller;
  List<String> pro=[];
  List<String> co=[];
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
    groupid: "",
  );

  @override
  void initState() {
    controller = VideoPlayerController.network(widget.UrlVideo);
    _initializeVideoPlayerFuture = controller.initialize();
    getuser();

    getpro2();
    controller.setLooping(true);
    super.initState();
  }

  getuser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user = UserModel.fromJson(jsonDecode(prefs.getString("user")!));
    });
  }
// setuser()async{
//   final prefs = await SharedPreferences.getInstance();
//  prefs.setString("user", jsonEncode(user));
// }
  @override
  void dispose() {
    controller.dispose();
    print("heye");

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
actions: [
  user.type=="coach"?IconButton(onPressed: (){}, icon:Icon(Icons.info_outlined)):Container()
],
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          'Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: Align(
          alignment: AlignmentDirectional(0.82, -0.21),
          child: FloatingActionButton(
            child: Icon(
              controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 30,
            ),
            backgroundColor: Colors.grey,
            onPressed: () {
              setState(() {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
              });
            },
          )),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF595858)],
            stops: [0.4, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(0, 1),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(-0.2, -0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'exercise duration',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '60 S',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.9, 0.2),
                child: TextButtonWidget(
                  level: "Level ${widget.level}",
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: MediaQuery.of(context).size.height * 0.044,
                ),
              ),

             widget.program? Container(): pro.contains(widget.id)||co.contains(widget.id)? Align(
                  alignment: AlignmentDirectional(0.3, 0.2),
                  child: InkWell(
                    onTap: () async {
                      remove();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      height: MediaQuery.of(context).size.height * 0.044,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0xFFBDBDBD),
                          )
                        ],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(-0.05, -0.05),
                        child: Text(
                          'Remove',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ))
                  : Align(
                  alignment: AlignmentDirectional(0.3, 0.2),
                  child: InkWell(
                    onTap: ()  {
                      if(co.length<5)
                     add2();

                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.32,
                      height: MediaQuery.of(context).size.height * 0.044,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color(0xFFBDBDBD),
                          )
                        ],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(-0.05, -0.05),
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: AlignmentDirectional(-0.85, -0.29),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.black,
                  child: Text(
                    widget.nameExercise,
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.9, -0.05),
                child: IconButtonWidget(
                  icon: Icons.timer_sharp,
                ),
              ),
              GestureDetector(
                onTap: () => _showBottomSheet(),
                child: Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.14,
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7,
                            color: Color(0xFFBDBDBD),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        border: Border.all(
                          color: Color(0xFFD6D6D6),
                          width: 0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.02, -0.2),
                            child: Text(
                              'Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.02, -0.5),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Container(
                                width: 100,
                                height:
                                MediaQuery.of(context).size.height * 0.007,
                                constraints: BoxConstraints(
                                  maxHeight:
                                  MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100),
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
              Align(
                alignment: AlignmentDirectional(0, -1.01),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showBottomSheet() {
    Get.bottomSheet(
      Align(
        alignment: AlignmentDirectional(0, 1),
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  color: Color(0xFFBDBDBD),
                )
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              border: Border.all(
                color: Color(0xFFD6D6D6),
                width: 0,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.02, -0.8),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 28,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.02, -0.9),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height * 0.007,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, -0.6),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 90, ),
                    child: Card(
                      elevation: 0,
                      color: Color(0xFFE0E0E0),
                      child: SingleChildScrollView(
                        child: Text(
                          widget.details,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void add() async{
  //   SharedPreferences pref=await SharedPreferences.getInstance();
  //
  //   pro.add(widget.id);
  //
  //   await pref.setStringList("pro", pro);
  //   print("heyy");
  //   Get.off(()=>HomePageWidget());
  //
  //
  // }

  // getpro() async {
  //   SharedPreferences pref=await SharedPreferences.getInstance();
  //   setState(() {
  //     pro=pref.getStringList("pro")!;
  //   });
  // }
  getpro2() async {
    SharedPreferences pref=await SharedPreferences.getInstance();
    setState(() {
      co=pref.getStringList("co")!;
    });
  }

  void remove() async{
    SharedPreferences pref=await SharedPreferences.getInstance();

    co.remove(widget.id);

    await pref.setStringList("co", co);print("heyy");
    Get.off(()=>add_program(email: widget.email));


  }

  void add2() async{
    SharedPreferences pref=await SharedPreferences.getInstance();

    co.add(widget.id);
    print("heyy");
    await pref.setStringList("co", co);
    Get.off(()=>add_program(email: widget.email));


  }
}
