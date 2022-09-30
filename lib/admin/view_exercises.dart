import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test66/admin/Edite_exrcies.dart';
import 'package:test66/admin/add_exercise.dart';

import '../user/models/Admin_module.dart';
import '../user/models/data_exercise.dart';
import '../user/models/notfication_module.dart';
class ViewExercises extends StatefulWidget {
  final AdminModule admin;
  const ViewExercises({Key? key, required this.admin}) : super(key: key);

  @override
  State<ViewExercises> createState() => _ViewExercises();
}

class _ViewExercises extends State<ViewExercises> {
  List all = [];
  List Results = [];
  late TextEditingController searchController;
  getexrcies() async {
    await FirebaseFirestore.instance
        .collection("exercies")
        .snapshots()
        .listen((event) {

            setState(() {
              all = event.docs;
              searchResultsList();
            });


    });
  }

  @override
  void initState() {
    getexrcies();
    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
    super.initState();
  }
  @override
  void dispose() {
   searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: all.isNotEmpty?Container():FloatingActionButton(onPressed: (){
        Get.to(()=>AddExerciseWidget(admin: widget.admin,));
      },child: Center(child: Icon(Icons.add),),),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 10),
            child: Material(
              color: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Color(0xFFEEEEEE),
                      spreadRadius: 2,
                    )
                  ],
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(7, 2, 0, 0),
                  child: TextFormField(
                    obscureText: false,
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Name',
                      hintText: 'Search',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 27,
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),

               Expanded(
                 child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: Results.length,
                  itemBuilder:(context, index) {
                    final exerciseBasic = ExrciesModule.fromJson(Results[index].data());
                    return GestureDetector(
                      onTap: (){
                     _showBottomSheet(admin: widget.admin,id: Results[index].id,exr: exerciseBasic);
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
              ),
               ),

        ],
      ),
    );
  }
  _showBottomSheet(  {required final ExrciesModule exr,
  required final String id,
  required final AdminModule admin,}) {
    // var email=widget.players.get("email");
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(15),
        child: Container(

          height: 200,
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.07, 0.76),
                  child: InkWell(
                    onTap: () async{


                      await Get.to(
                        ()=>AddExerciseWidget(admin: admin,),
                        transition: Transition.cupertinoDialog,
                        curve: Curves.easeInOutSine,
                        duration: Duration(seconds: 2),
                      );
                      Get.back();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Color(0x76757575),
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'Add Exrcies',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
               Align(
                  alignment: AlignmentDirectional(-0.05, 0.73),
                  child: InkWell(
                    onTap: () async{
                    if(exr.lock){
                      var snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Warning',
                          message: "the exrciess is been update by another admin",
                          contentType: ContentType.success,
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                     await Get.to(()=>EditExerciseWidget(exr: exr, id: id, admin: admin));
                     Get.back();
                    }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: Color(0x81757575),
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'Edit Exrcies',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                     Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: AlignmentDirectional(-0.05, 1),
                    child: InkWell(
                      onTap: () {
                        remove(id,exr,admin);
                        // print(widget.players.id);
                        // print(widget.user.email);
                        // print(widget.players.id);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Color(0xFFA00707),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: Color(0x81757575),
                              spreadRadius: 2,
                            )
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'Remove ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFFFFEBEE),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (searchController.text != "") {
      for (var i in all) {
        var title = returnname(i);

        if (title.toLowerCase().contains(searchController.text.toLowerCase())) {
          showResults.add(i);
        }
      }
    } else {
      for (var i in all) showResults.add(i);
    }
    setState(() {
      Results = showResults;
    });
  }

  returnname(DocumentSnapshot snapshot) {
    return snapshot.get("exerciseName");
  }

  void remove(String id,ExrciesModule exr,AdminModule admin) async{
    await FirebaseFirestore.instance.collection("exercies").doc(id).delete().then((value){
      NotfiModule not = NotfiModule(
          type: "N",
          title: "Remove Exrcies",
          message: "Exrcies name: ${exr.exerciseName}",
          bywho: admin.name,
          date: Timestamp.now().toDate().toString());
      FirebaseFirestore.instance.collection("logs").add(not.toJson()).then((value){
        var snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success',
            message: "the exrciess Remove ",
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Get.back();

      });
    });
  }
}

