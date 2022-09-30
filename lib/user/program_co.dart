import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test66/user/detales_exr_co.dart';
import 'package:test66/user/widget/exercise_details.dart';

import '../components/widget_exercise.dart';
import 'models/User_model.dart';
import 'models/data_exercise.dart';
class program_co extends StatefulWidget {
  final UserModel user;
  const program_co({Key? key, required this.user}) : super(key: key);

  @override
  State<program_co> createState() => _program_coState();
}

class _program_coState extends State<program_co> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;


  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                  child: Align(
                      alignment: AlignmentDirectional(0, 0.8),
                      child: Text(
                        'Your Program',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),

            ],
            indicatorWeight: 25,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFFC0004), Color(0xFF7E0404)]),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: Color(0xFF060606),
          automaticallyImplyLeading: true,
          title: Center(
            child: Text(
              ' Program',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        backgroundColor: Colors.black,
        body: TabBarView(
          controller: tabController,
          children: [daily_program(user: widget.user,)],
        ));
  }
}

class daily_program extends StatefulWidget {
  final UserModel user;
  const daily_program({Key? key, required this.user, }) : super(key: key);

  @override
  State<daily_program> createState() => _daily_programState();
}

class _daily_programState extends State<daily_program> {
  List dp = [];
  List all=[];

  bool isloading=false;


  @override
  void initState() {
    getprogram();
    getexrcies();
    super.initState();
  }
  getexrcies() async {
    FirebaseFirestore.instance
        .collection("exercies")
        .snapshots()
        .listen((event) {
      setState(() {
        all = event.docs;
      });
    });

  }
  void getprogram() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user.email)
        .collection("dp")
        .snapshots()
        .listen((event){
      setState(() {
        dp = event.docs;
      });
    });
    print(dp);
  }
  filter(String id){
    for(var i in all){
      if(i.get("id")==id){
        return i.data();
      }
    }
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return dp.isNotEmpty&&all.isNotEmpty?SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
          child: ListView.builder(
            itemCount: dp.length,
            itemBuilder: (BuildContext context, int index) {
              var exr =filter(dp[index].get("id"));
              final exerciseBasic = ExrciesModule.fromJson(exr);

              return WidgetExercise(
                  exerciseName:  exerciseBasic.exerciseName!,
                  ExerciseImage: exerciseBasic.urlImage!,
                  levelExercise: exerciseBasic.level!,
                  widget: exr_deatils(UrlVideo:exerciseBasic.urlVideo!,
                    nameExercise:exerciseBasic.exerciseName!,
                    level:exerciseBasic.level!,
                    details:exerciseBasic.details!, id: exerciseBasic.id!, email: widget.user.email, program: true,));
              print(exr);
              return Container();
            },
          ),
        )):Container();
  }
}


