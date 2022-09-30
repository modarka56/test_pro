import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test66/user/home_page.dart';
import 'package:test66/user/widget/exercise_details.dart';

import '../components/widget_exercise.dart';
import 'models/User_model.dart';
import 'models/data_exercise.dart';

class program extends StatefulWidget {
  final UserModel user;
  final int id;
  const program({Key? key, required this.user, required this.id}) : super(key: key);

  @override
  State<program> createState() => _programState();
}

class _programState extends State<program> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController tabController;


  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this,initialIndex: widget.id);
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
             widget.user.type=="coach"? Container(): Tab(
                  child: Align(
                      alignment: AlignmentDirectional(0, 0.8),
                      child: Text(
                        'coach',
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
          children: [daily_program(user: widget.user,), widget.user.type=="coach"?Container():coach_program(user: widget.user,)],
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
              if(exr==null){
                return Container();
              }
              final exerciseBasic = ExrciesModule.fromJson(exr);

                return WidgetExercise(
                    exerciseName:  exerciseBasic.exerciseName!,
                    ExerciseImage: exerciseBasic.urlImage!,
                    levelExercise: exerciseBasic.level!,
                    widget: DetilsWidget(exerciseBasic.urlVideo!,
                      exerciseBasic.exerciseName!,
                      exerciseBasic.level!,
                      exerciseBasic.details!, id: exerciseBasic.id!, email: widget.user.email,time: exerciseBasic.numberOfTraining!,exrid: dp[index].id,));
print(exr);
return Container();
            },
          ),
    )):Container();
  }
}

class coach_program extends StatefulWidget {
  final UserModel user;
  const coach_program({Key? key, required this.user,}) : super(key: key);

  @override
  State<coach_program> createState() => _coach_programState();
}

class _coach_programState extends State<coach_program> {
  List cp = [];
  List all=[];
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
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.user.email)
        .collection("co")
        .snapshots()
        .listen((event) {
      setState(() {
        cp = event.docs;
      });
    });
  }
  filter(String id){
    for(var i in all){
      if(i.get("id")==id){
        return i.data();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return cp.isNotEmpty&&all.isNotEmpty?SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
          child: ListView.builder(
            itemCount: cp.length,
            itemBuilder: (BuildContext context, int index) {
              var exr =filter(cp[index].get("id"));
              if(exr==null){
                return Container();
              }
              final exerciseBasic = ExrciesModule.fromJson(exr);

              return WidgetExercise(
                  exerciseName:  exerciseBasic.exerciseName!,
                  ExerciseImage: exerciseBasic.urlImage!,
                  levelExercise: exerciseBasic.level!,
                  widget: DetilsWidget(exerciseBasic.urlVideo!,
                    exerciseBasic.exerciseName!,
                    exerciseBasic.level!,
                    exerciseBasic.details!, id: exerciseBasic.id!, email: widget.user.email,time: exerciseBasic.numberOfTraining!,exrid: cp[index].id));
              print(exr);
              return Container();
            },
          ),
        )):Center(
      child: InkWell(
        onTap: (){
          print("hey");
        },
        child: Container(
          padding: EdgeInsets.only(left: 15,top: 18),
          height: MediaQuery.of(context).size.height*0.1,
          width:  MediaQuery.of(context).size.width*0.25,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)

          ),
          child: Text(
            "no \n program ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
      ),
    );
  }
}
