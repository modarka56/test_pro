import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/user/home_page.dart';
import 'package:test66/user/widget/widgets.dart';

import '../admin/add_exercise.dart';
import 'models/User_model.dart';

class Userdataset extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String phone;

  const Userdataset(
      {Key? key,
      required this.username,
      required this.email,
      required this.password,
      required this.phone})
      : super(key: key);

  @override
  State<Userdataset> createState() => _UserdatasetState();
}

class _UserdatasetState extends State<Userdataset> {
  var gender = [
    'male',
    'female',
  ];
  List value = [];
  List musles = [
    'Upper extremity muscles',
    'Lower extremity muscles',
    'Trunk muscles'
  ];

  bool write = false;
  var country1;
  var _curantstate = "Chosse gender";
  String imageString =
      "https://firebasestorage.googleapis.com/v0/b/t-gym-58401.appspot.com/o/no.jpg?alt=media&token=59246c51-34e6-4641-a7b9-1e4d5f4e73b9";

  String imagepath = "";
  TextEditingController agecontroller = new TextEditingController();
  TextEditingController hightcontroller = new TextEditingController();
  TextEditingController wheightcontroller = new TextEditingController();
  TextEditingController textController4 = new TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String dropDownValue1;
  late String dropDownValue2;
  late GroupButtonController _checkboxesController;
  late List<String> checkboxGroupValues;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    _checkboxesController = GroupButtonController(
      onDisablePressed: (index) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('hey is disabled')),
      ),
    );
    dropDownValue2 = "";
    dropDownValue1 = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text(
          'Complete Info',
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
              padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 25),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: InkWell(
                      onTap: getImage,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: MediaQuery.of(context).size.width * 0.43,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          children: [
                            Align(
                                alignment: AlignmentDirectional(-0.03, 0.01),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      imagepath.isEmpty
                                          ? imageString
                                          : imagepath),
                                  radius: 100,
                                )),
                            Align(
                              alignment: AlignmentDirectional(0.98, 0.81),
                              child: Icon(
                                Icons.camera_rounded,
                                color: Color(0xFF212121),
                                size: 45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        color: Color(0xFF757575),
                        size: 35,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(11, 0, 0, 0),
                          child: TextFormField(
                            controller: agecontroller,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'age ',
                              hintText: 'enter  your age',
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
                            keyboardType: TextInputType.number,
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
                          Icons.account_circle_rounded,
                          color: Color(0xFF757575),
                          size: 33,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: TextFormField(
                              controller: hightcontroller,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Height',
                                hintText: 'Your Height',
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
                              keyboardType: TextInputType.number,
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
                            controller: wheightcontroller,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Weight',
                              hintText: 'Your weight',
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
                              dropDownList: gender,
                              dropDownBorderRadius: 2,
                              onDropDownItemClick: (item) {
                                setState(() {
                                  dropDownValue2 = item;
                                });
                              },
                              selectedItem: dropDownValue2.isEmpty
                                  ? "Gender"
                                  : dropDownValue2,
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
                        'player',
                        'coach',
                      ],
                      dropDownBorderRadius: 2,
                      onDropDownItemClick: (item) {
                        setState(() {
                          dropDownValue1 = item;
                        });
                      },
                      selectedItem:
                          dropDownValue1.isEmpty ? "chose" : dropDownValue1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(90, 30, 0, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          maximumSize: Size(200, 200),
                          fixedSize: Size(400, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          minimumSize: Size(50, 50),
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 20)),
                      child: country1 != null
                          ? Text(country1)
                          : Text("chosse country"),
                      onPressed: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.blueGrey),
                            bottomSheetHeight: 500,
                            // Optional. Country list modal height
                            //Optional. Sets the border radius for the bottomsheet.
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            //Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              labelText: 'Search',
                              hintText: 'Start typing to search',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country) => setState(() {
                            country1 =
                                "${country.flagEmoji} ${country.countryCode}";
                          }),
                        );
                      },
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
                              print(value);
                              return;
                            }

                            value.remove(musles[index]);

                            _checkboxesController.unselectIndex(index);
                          },

                        );
                      },
                      onSelected: (val, i, selected) =>
                          print('Button: $val index: $i $selected'),
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
    if ((agecontroller.text.isEmpty || agecontroller.text == " ") ||
        (wheightcontroller.text.isEmpty || wheightcontroller.text == " ") ||
        (hightcontroller.text.isEmpty || hightcontroller.text == " ") ||
        dropDownValue1 == "" ||
        dropDownValue2 == "" ||
        country1 == null) {
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

  Widget buliddropdown() {
    return SizedBox(
      width: 150,
      child: AwesomeDropDown(
        dropDownList: gender,
        dropDownIcon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey,
          size: 23,
        ),
        selectedItem: _curantstate == null ? "chosse gender" : _curantstate,
        padding: 8,
        onDropDownItemClick: (selectedItem) {
          _curantstate = selectedItem;
        },
        // dropDownBorderRadius: 10,
        // dropDownTopBorderRadius: 50,
        // dropDownBottomBorderRadius: 50,
        // dropDownIconBGColor: Colors.transparent,
        // dropDownOverlayBGColor: Colors.transparent,
        // dropDownBGColor: Colors.white,
        // selectedItemTextStyle: TextStyle(
        //     color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
        dropDownListTextStyle: TextStyle(
            color: Colors.grey,
            fontSize: 15,
            backgroundColor: Colors.transparent),
      ),
    );
  }

  Future getImage() async {
    // Get image from gallery.
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    File videoo = File(pickedfile!.path);
    _uploadvideoToFirebase(videoo);
  }

  Future<void> _uploadvideoToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation = 'images/profiles/${widget.email}/img${randomNumber}.jpg';
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
      String imagestring = await ref.getDownloadURL();

      // Add location and url to database

      // await FirebaseFirestore.instance
      //     .collection("images")
      //     .doc(user.email)
      //     .collection("listimages").doc(user.email).set({'url':imageString , 'location':text});
      // await FirebaseFirestore.instance.collection("group").doc(user.email).update({'image':imageString});

      setState(() {
        imagepath = imagestring;
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

  void save() async{
    final prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel(
        image: imagepath.isEmpty ? imageString : imagepath,
        name: widget.username.trim().toLowerCase(),
        email: widget.email.trim().toLowerCase(),
        phone: widget.phone,
        password: widget.password,
        age: int.parse(agecontroller.text.trim()),
        hight: int.parse(hightcontroller.text.trim()),
        weight: int.parse(wheightcontroller.text.trim()),
        sex: dropDownValue2.trim(),
        online: true,
        level: dropDownValue1=="coach"?8:0,
        country: country1,
        type: dropDownValue1.trim(),
        lastonline: Lastonline(
            day: Timestamp.now().toDate().day,
            year: Timestamp.now().toDate().year,
            month: Timestamp.now().toDate().month),
        musclesinjured: value,
        ingroup: "no",
        groupid: "", );
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: widget.email.trim().toLowerCase(), password: widget.password)
          .then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.email)
            .set(user.toJson())
            .then((val) async{
          await prefs.setString("user", json.encode(user));
          await prefs.setStringList("pro", []);
          var snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Great Welcome',
              message: " ${value.user!.email} ",
              contentType: ContentType.success,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Timer(Duration(seconds: 3), () {
            Get.off(() => HomePageWidget(id: 1,),
                transition: Transition.fadeIn,

                duration: Duration(seconds: 2));
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
