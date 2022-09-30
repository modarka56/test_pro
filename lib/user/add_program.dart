import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/models/data_exercise.dart';
import 'package:test66/user/widget/exercise_details.dart';

import 'detales_exr_co.dart';

class add_program extends StatefulWidget {
  final String email;
  const add_program({Key? key, required this.email}) : super(key: key);

  @override
  State<add_program> createState() => _add_programState();
}

class _add_programState extends State<add_program> {
  List all =[];
  List<String> value=[];
   UserModel? user;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool issave=false;
@override
  void initState() {
   getexrcies();
   getuser();
   setpro();
    super.initState();
  }



  setpro()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  var cre=pref.getBool("cre")!;
  if(cre){
    print("true");
    setState(() {
      value= pref.getStringList("co")!;
    });
  }else{
    print("fasle");
    await pref.setStringList("co", []);
    await pref.setBool("cre", true);
  }

  }
  getexrcies() async {
    await FirebaseFirestore.instance
        .collection("exercies")
        .snapshots()
        .listen((event) {
      setState(() {
         all = event.docs;
      });
    });
  }
  getuser()async{
  await FirebaseFirestore.instance.collection("users").doc(widget.email).snapshots().listen((event) {
    setState(() {
      user=UserModel.fromJson(event.data()!);
    });
  });
  }

  @override
  void dispose() {
    print("hey");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          value.length == 2
              ? IconButton(
              onPressed: () {
                if(issave){
                  var snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Oh snap ',
                      message:
                      "you save your program for today",
                      contentType: ContentType.warning,
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }else{
print(value);
print("save");
                  save();
                }

              },
              icon: Icon(CupertinoIcons.checkmark_alt_circle))
              : Container()
        ],
        automaticallyImplyLeading: true,
        title: Text(
          'Add Program',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),

        centerTitle: false,
        elevation: 2,
      ),

      body: all.isNotEmpty?Column(
        children: [


          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: all.length,
              itemBuilder:(context, index) {
                ExrciesModule exr=ExrciesModule.fromJson(all[index].data());
                if(exr.level!<=user!.level){
                  return GestureDetector(
                    onTap: (){
                      Get.to(()=>exr_deatils(UrlVideo:exr.urlVideo!,
                        nameExercise:exr.exerciseName!,
                        level:exr.level!,
                        details:exr.details!, id: exr.id!, email: widget.email, program: false,));
                    },
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
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 20,
                                  color: Color(0xFFEEEEEE),
                                  spreadRadius: 2,
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  elevation:0,
                                  shape: const CircleBorder(),
                                  child: Container(
                                      width: 100,
                                      height: 100,
                                      color: Color(0xFF9296f0),
                                      child:Icon(Icons.sports_kabaddi,
                                        size: 60,)
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Align(
                                      alignment: AlignmentDirectional(-0.44, -0.72),
                                      child: Text(
                                        'Name exercise : ${exr.exerciseName}',
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
                                        'Level : ${exr.level}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
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
                      ),
                    ),
                  );
                }else{
                  return Container();
                }

              },
            ),
          ),

        ],
      ):Center(child: CircularProgressIndicator(),)
    );
  }

  void save() async {
    try{
      for (int i=0;i<value.length;i++) {

        await FirebaseFirestore.instance
            .collection("users")
            .doc(widget.email)
            .collection("co")
            .doc(i.toString())
            .set({"id": value[i]}).then((value) {
          print("hey");
        });
      }
      issave=true;
    }catch(e){

    }
  }
}
