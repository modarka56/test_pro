import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test66/user/models/Admin_module.dart';
import 'package:test66/user/models/data_exercise.dart';

import '../user/models/notfication_module.dart';


class AddExerciseWidget extends StatefulWidget {
  final AdminModule admin;
  const AddExerciseWidget({Key? key, required this.admin}) : super(key: key);

  @override
  _AddExerciseWidgetState createState() => _AddExerciseWidgetState();
}

class _AddExerciseWidgetState extends State<AddExerciseWidget>
    with SingleTickerProviderStateMixin {
  late List<String> checkboxGroupValues;

  late TextEditingController textController3;
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController4;
  late String dropDownValue1;
  late String dropDownValue2;
  late File image;
  bool pickimage=false;
  bool pickvideo=false;
  late GroupButtonController _checkboxesController;
  List musles = ['Upper extremity muscles',
    'Lower extremity muscles',
    'Trunk muscles'];
  List value = [];
  String imageString =
      "https://firebasestorage.googleapis.com/v0/b/t-gym-58401.appspot.com/o/no.jpg?alt=media&token=59246c51-34e6-4641-a7b9-1e4d5f4e73b9";

  late String imagepath;
  String video = "https://firebasestorage.googleapis.com/v0/b/t-gym-58401.appspot.com/o/No%20Video%20Available.mp4?alt=media&token=fbdbbfc8-2785-4f0a-a104-99db60b5f648";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    _checkboxesController = GroupButtonController(
      selectedIndexes: [],

      onDisablePressed: (index) =>
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('hey is disabled')),

          ),
    );
    dropDownValue2 = "";
    dropDownValue1 = "";
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          'Add Exercise',
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                15, 0, 0, 0),
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
                                'basic', 'fitnece', "power", "speed"
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
                      dropDownList: [
                        '0',
                        '1',
                        '2',
                        '3',
                        '4',
                        '5',
                        '6',
                        '7',
                        '8'
                      ],
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
                              value.add(musles[index],);

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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              maximumSize: Size(200, 200),
                              fixedSize: Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              minimumSize: Size(50, 50),
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 20)
                          ),
                          onPressed: getImage,
                          child: Text("Add Image"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                              maximumSize: Size(200, 200),
                              fixedSize: Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              minimumSize: Size(50, 50),
                              textStyle: TextStyle(
                                  color: Colors.black, fontSize: 20)
                          ),
                          onPressed: getVideo,
                          child: Text("Add video"),
                        ),
                      ],
                    ),
                  ),
                  pickvideo||pickimage?Container(child: Center(child: CircularProgressIndicator(),),):Padding(
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
                          textStyle: TextStyle(color: Colors.black,
                              fontSize: 20)
                      ),
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

  Future getImage() async {
    setState(() {
      pickimage=true;
    });
    // Get image from gallery.
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(pickedfile!.path);
    _uploadImageToFirebase(image);
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation =
          'images/exrcies/img${randomNumber}.jpg';
      // String imageLocation = 'video/video${randomNumber}.mp4';

      // Upload image to firebase.
      final Reference = FirebaseStorage.instance.ref().child(imageLocation);

      final uploadTask =
      Reference.putFile(image).whenComplete(() => print("uploadcomplet"));
      await uploadTask
          .whenComplete(() => _addPathToDatabase(imageLocation));
    } catch (e) {
      print(e);
    }
  }


  Future<void> _addPathToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage.instance.ref().child(text);
      imageString = await ref.getDownloadURL();

      // Add location and url to database

      // await FirebaseFirestore.instance
      //     .collection("images")
      //     .doc(user.email)
      //     .collection("listimages").doc(user.email).set({'url':imageString , 'location':text});
      // await FirebaseFirestore.instance.collection("group").doc(user.email).update({'image':imageString});

      setState(() {
        imagepath = imageString;
        // user.image=imageString;
        pickimage=false;
      });
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          });
    }
  }

  Future getVideo() async {
    // Get image from gallery.
    setState(() {
      pickvideo=true;
    });
    var pickedfile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    File videoo = File(pickedfile!.path);
    _uploadvideoToFirebase(videoo);
  }

  Future<void> _uploadvideoToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation =
          'videos/exrcies/vid${randomNumber}.mp4';
      // String imageLocation = 'video/video${randomNumber}.mp4';

      // Upload image to firebase.
      final Reference = FirebaseStorage.instance.ref().child(imageLocation);

      final uploadTask =
      Reference.putFile(image).whenComplete(() => print("uploadcomplet"));
      await uploadTask
          .whenComplete(() => _addPathvideoToDatabase(imageLocation));
    } catch (e) {
      print(e);
    }
  }


  Future<void> _addPathvideoToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage.instance.ref().child(text);
      String vidoestring = await ref.getDownloadURL();

      // Add location and url to database

      // await FirebaseFirestore.instance
      //     .collection("images")
      //     .doc(user.email)
      //     .collection("listimages").doc(user.email).set({'url':imageString , 'location':text});
      // await FirebaseFirestore.instance.collection("group").doc(user.email).update({'image':imageString});

      setState(() {
        video = vidoestring;
        pickvideo=false;
        // user.image=imageString;
      });
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.toString()),
            );
          });
    }
  }

  validtions() {
    var anime = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    if ((textController1.text.isEmpty || textController1.text == " ") ||
        (textController2.text.isEmpty || textController2.text == " ") ||
        (textController3.text.isEmpty || textController3.text == " ")||dropDownValue1==""||dropDownValue2=="") {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        animation: anime,
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

  save() {
    ExrciesModule exr = ExrciesModule(
      exerciseName: textController1.text.trim().toLowerCase(),
      details: textController2.text,
      numberOfTraining: textController3.text,
      level: dropDownValue1 == "" ? 0 : int.parse(dropDownValue1),
      type: dropDownValue2 == "" ? "basic" : dropDownValue2,
      id: Random().nextInt(100000).toString(),
      urlImage: imageString,
      urlVideo: video,
      musclesLearned: value, lock: false,

    );
    try {
      FirebaseFirestore.instance.collection("exercies").add(exr.toJson()).then((
          value) {
        print("okeyyyy");
        NotfiModule not = NotfiModule(
            type: "N",
            title: "Add Exrcies ",
            message: "Exrcies name: ${exr.exerciseName}",
            bywho: widget.admin.name,
            date: Timestamp.now().toDate().toString());
        FirebaseFirestore.instance.collection("logs").add(not.toJson()).then((value){
          var snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success',
              message: "the exrciess added",
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
      print(e);
    }
  }
}


class CheckBoxTile extends StatefulWidget {
  const CheckBoxTile({
    Key? key,
    required this.selected,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final String title;
  final bool selected;
  final VoidCallback onTap;


  @override
  State<CheckBoxTile> createState() => _CheckBoxTileState();
}

class _CheckBoxTileState extends State<CheckBoxTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title),
          onTap: widget.onTap,
          leading: Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.all<Color?>(Colors.black),
            value: widget.selected,
            onChanged: (val) {
              widget.onTap();
            },
          ),
        ),

      ],
    );
  }
}