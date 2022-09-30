import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test66/admin/Details_exr.dart';

import '../user/models/data_exercise.dart';

class report_page extends StatefulWidget {
  const report_page({Key? key}) : super(key: key);

  @override
  State<report_page> createState() => _report_pageState();
}

class _report_pageState extends State<report_page> {
  List all = [];
  List Results = [];
  List value = [];

  getexrcies() async {
    await FirebaseFirestore.instance
        .collection("exercies")
        .snapshots()
        .listen((event) {

      setState(() {
        all = event.docs;
        // ResultsList();
      });


    });
  }
  @override
  void initState() {
    getexrcies();
   getreports();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
     appBar: AppBar(
elevation: 0,
       backgroundColor:Color(0xFFFAFAFA),
      title: Text("Report page",style: TextStyle(color: Colors.black),),
       iconTheme: IconThemeData(
           color: Colors.black,
           size: 30
       ),
     ),
      body: Column(
        children: [


          Expanded(
            child:ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: value.length,
              itemBuilder:(context, index) {

                  final exerciseBasic = ExrciesModule.fromJson(value[index].data());
                  return GestureDetector(
                    onTap: (){
Get.to(Detalis_exr(exr: exerciseBasic));
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
                                      child:Image.network(exerciseBasic.urlImage!,fit: BoxFit.fill,)
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
                                        ' ${exerciseBasic.exerciseName}',
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
                                        'Level : ${exerciseBasic.level}',
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


              },

          ),)

        ],
      ),
    );
  }

  void ResultsList() {
    for(int i=0;i<Results.length;i++){
      for(int j=0;j<all.length;j++){
        if(all[j].id==Results[i].id){
         value.add(all[j]);
        }
      }
    }

  }

  void getreports() async{
    await FirebaseFirestore.instance.collection("exrcies_report").snapshots().listen((event) {
setState(() {
  Results=event.docs;
  ResultsList();
});
    });
  }

  // bool filter(String id) {
  //   for(int i=0;i<all.length;i++){
  //     if(all[i].id==id){
  //       return true;
  //     }
  //   }
  //   return false;
  // }
}
