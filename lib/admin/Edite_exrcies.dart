import 'dart:async';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:group_button/group_button.dart';
import 'package:test66/user/models/Admin_module.dart';
import 'package:test66/user/models/notfication_module.dart';

import '../user/models/data_exercise.dart';
import 'add_exercise.dart';

class EditExerciseWidget extends StatefulWidget {
  final ExrciesModule exr;
  final String id;
  final AdminModule admin;

  const EditExerciseWidget(
      {Key? key, required this.exr, required this.id, required this.admin})
      : super(key: key);

  @override
  _EditExerciseWidgetState createState() => _EditExerciseWidgetState();
}

class _EditExerciseWidgetState extends State<EditExerciseWidget> {
  List<String> checkboxGroupValues = [];
  String dropDownValue1 = "";
  late TextEditingController textController3;
  late TextEditingController textController1;
  late TextEditingController textController2;
  String dropDownValue2 = "";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late GroupButtonController _checkboxesController;
  List musles = [
    'Upper extremity muscles',
    'Lower extremity muscles',
    'Trunk muscles'
  ];
  List value = [];

  @override
  void initState() {
    super.initState();
    lockexr();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

    initetext();
  }
  lockexr()async{
    await FirebaseFirestore.instance.collection("exercies").doc(widget.id).update({"lock":true}).then((value){
      print("lock");
    });
  }
unlock()async{
  await FirebaseFirestore.instance.collection("exercies").doc(widget.id).update({"lock":false}).then((value){
    print("unlock");
  });
}
  @override
  void dispose() {
    unlock();
    super.dispose();
  }

  void initetext() {
    textController1.text = widget.exr.exerciseName!;
    textController2.text = widget.exr.details!;
    textController3.text = widget.exr.numberOfTraining!;

    dropDownValue2 = widget.exr.type!;
    dropDownValue1 = widget.exr.level.toString();
    List<int> x=[];
    for(int i=0;i<widget.exr.musclesLearned!.length;i++){
      if(widget.exr.musclesLearned!.contains(musles[i])){
        x.add(i);
      }
    }
    _checkboxesController = GroupButtonController(
      selectedIndexes: x,
      onDisablePressed: (index) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('hey is disabled')),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          'Edit Exercise',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 25, 15, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.fitness_center_rounded,
                        color: Color(0xFF757575),
                        size: 35,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(11, 0, 0, 0),
                          child: TextFormField(
                            controller: textController1,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'name ',
                              hintText: 'enter the name Exercise',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF212121),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF212121),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.mode_edit,
                          color: Color(0xFF757575),
                          size: 33,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: TextFormField(
                              controller: textController2,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Details',
                                hintText: 'Exercise details...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF303030),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF303030),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              style: TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(45, 30, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: textController3,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'number of exercise',
                              hintText: 'number of exercise',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF757575),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF757575),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 14,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                          child: Container(
                            height: 50,
                            width: 150,
                            child: AwesomeDropDown(
                              isPanDown: true,
                              dropDownList: [
                                'basic',
                                'fitnece',
                                "power",
                                "speed"
                              ],
                              dropDownBorderRadius: 2,
                              onDropDownItemClick: (item) {
                                setState(() {
                                  dropDownValue2 = item;
                                });
                              },
                              selectedItem: dropDownValue2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(45, 30, 0, 0),
                    child: AwesomeDropDown(
                      isPanDown: true,
                      dropDownList: ['0', '1', '2', '3', '4', '5', '6', '7', '8'],
                      dropDownBorderRadius: 2,
                      onDropDownItemClick: (item) {
                        setState(() {
                          dropDownValue1 = item;
                        });
                      },
                      selectedItem: dropDownValue1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                    child: Text(
                      'Muscles learned from exercise',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                    child: GroupButton(
                      controller: _checkboxesController,
                      isRadio: false,
                      options: GroupButtonOptions(
                        groupingType: GroupingType.column,
                      ),
                      buttons: musles,
                      buttonIndexedBuilder: (selected, index, context) {
                        return CheckBoxTile(
                          title: musles[index],
                          selected: selected,
                          onTap: () {
                            if (!selected) {
                              _checkboxesController.selectIndex(index);
                              value.add(musles[index]);

                              return;
                            }
                            value.remove(musles[index]);
                            _checkboxesController.unselectIndex(index);
                          },
                        );
                      },
                      onSelected: (val, i, selected) =>
                          debugPrint('Button: $val index: $i $selected'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(120, 10, 0, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          maximumSize: Size(200, 200),
                          fixedSize: Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          minimumSize: Size(50, 50),
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 20)),
                      onPressed: () {
                        validtions();
                      },
                      child: Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  validtions() {
    if ((textController1.text.isEmpty || textController1.text == " ") ||
        (textController2.text.isEmpty || textController2.text == " ") ||
        (textController3.text.isEmpty || textController3.text == " ") ||
        dropDownValue1 == "" ||
        dropDownValue2 == "") {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh Snap',
          message: "fileds requeris fill up please",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      save();
    }
  }

  save() async {
    ExrciesModule exr = ExrciesModule(
      exerciseName: textController1.text.trim().toLowerCase(),
      details: textController2.text,
      numberOfTraining: textController3.text,
      level: int.parse(dropDownValue1),
      type: dropDownValue2,
      id: widget.exr.id,
      urlImage: widget.exr.urlImage,
      urlVideo: widget.exr.urlVideo,
      musclesLearned: value,
      lock: false,
    );
    try {
      await FirebaseFirestore.instance
          .collection("exercies")
          .doc(widget.id)
          .update(exr.toJson())
          .then((value) {

        NotfiModule not = NotfiModule(
            type: "N",
            title: "Edit Exrcies ",
            message: "Exrcies name: ${widget.exr.exerciseName}",
            bywho: widget.admin.name,
            date: Timestamp.now().toDate().toString());
        FirebaseFirestore.instance.collection("logs").add(not.toJson()).then((value){
          var snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success',
              message: "the exrciess updated",
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Timer(Duration(milliseconds: 1500), (){
            Get.back();
          });
        });
      });
    } catch (e) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Oh Snapp',
          message: "somthing wrong please  try again ,${e}  ",
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
