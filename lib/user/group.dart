import 'dart:io';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/models/groupinfo_module.dart';
import 'package:test66/user/models/postp_module.dart';
import 'package:video_player/video_player.dart';

import 'models/post_module.dart';

class GroupWidget extends StatefulWidget {
  final GroupinfoModule group;
  final UserModel user;

  const GroupWidget({Key? key, required this.group, required this.user})
      : super(key: key);

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  late TextEditingController textController;
  bool isopen = false;
  bool isloading = false;
  late File image;
  String imagepath = "";
  String video = "";
  List posts = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    getposts();
  }

  getposts() async {
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(widget.group.name)
        .collection("posts")
        .snapshots()
        .listen((event) {
      setState(() {
        posts = event.docs;
      });
    });
  }

  Future getImage() async {
    // Get image from gallery.
    setState(() {
      isloading = true;
    });
    var pickedfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = File(pickedfile!.path);
    _uploadImageToFirebase(image);
  }

  Future<void> _uploadImageToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation =
          'images/groups/${widget.group.name}/img${randomNumber}.jpg';
      // String imageLocation = 'video/video${randomNumber}.mp4';

      // Upload image to firebase.
      final Reference = FirebaseStorage.instance.ref().child(imageLocation);

      final uploadTask =
          Reference.putFile(image).whenComplete(() => print("uploadcomplet"));
      await uploadTask.whenComplete(() => _addPathToDatabase(imageLocation));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _addPathToDatabase(String text) async {
    try {
      // Get image URL from firebase
      final ref = FirebaseStorage.instance.ref().child(text);
      imagepath = await ref.getDownloadURL();

      // Add location and url to database

      // await FirebaseFirestore.instance
      //     .collection("images")
      //     .doc(user.email)
      //     .collection("listimages").doc(user.email).set({'url':imageString , 'location':text});
      // await FirebaseFirestore.instance.collection("group").doc(user.email).update({'image':imageString});

      setState(() {
        isloading = false;
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
      isloading = true;
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
          'videos/groups/${widget.group.name}/vid${randomNumber}.mp4';
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
        isloading = false;
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

  @override
  void dispose() {
    textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF080101),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            widget.group.name,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF080101),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x39000000),
                              offset: Offset(0, 1),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 16, 12, 24),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 12),
                                    child: Text(
                                      posts.length.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFFFFEBEE),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'POSTS',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 12),
                                        child: Text(
                                          '8',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFFFFEBEE),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'PLAYERS',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              PostModule post =
                                  PostModule.fromJson(posts[index].data()!);
                              if (post.type == "T") {
                                return Textcontainer(
                                  post: post,
                                );
                              } else {
                                if (post.type == "I") {
                                  return imagecontainer(
                                    post: post,
                                  );
                                } else {
                                  return videocontainer(
                                    post: post,
                                  );
                                }
                              }
                            }),
                      )
                    ],
                  ),
                ),
                widget.user.type == "coach"&& widget.user.email==widget.group.email
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                            child: InkWell(
                              onTap: () {
                                send();
                              },
                              child: Material(
                                color: Colors.transparent,
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  height:
                                      MediaQuery.of(context).size.height * 0.065,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        25, 0, 0, 0),
                                    child: TextFormField(
                                      maxLength: 255,
                                      controller: textController,
                                      autofocus: true,
                                      obscureText: false,

                                      decoration: InputDecoration(
                                        hintText: 'Write here...',
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
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF9E9E9E),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8.0, right: 5),
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF343030),
                                        Color(0xFF010101)
                                      ],
                                      stops: [0.1, 0.9],
                                      begin: AlignmentDirectional(1, 0.98),
                                      end: AlignmentDirectional(-1, -0.98),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    hoverColor: Colors.transparent,
                                    iconSize: 60,
                                    icon: Icon(
                                      Icons.video_collection,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                    onPressed: getVideo,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8.0, right: 5),
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF343030),
                                        Color(0xFF090909)
                                      ],
                                      stops: [0.1, 0.9],
                                      begin: AlignmentDirectional(1, 0.98),
                                      end: AlignmentDirectional(-1, -0.98),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    hoverColor: Colors.transparent,
                                    iconSize: 60,
                                    icon: Icon(
                                      Icons.image,
                                      color: Color(0xFFFFFAFA),
                                      size: 25,
                                    ),
                                    onPressed: getImage,
                                  ),
                                ),
                              ),
                              !isloading
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8.0, right: 5),
                                      child: Material(
                                        color: Colors.transparent,
                                        elevation: 7,
                                        shape: const CircleBorder(),
                                        child: Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF343030),
                                                Color(0xFF080101)
                                              ],
                                              stops: [0.1, 0.9],
                                              begin:
                                                  AlignmentDirectional(1, 0.98),
                                              end:
                                                  AlignmentDirectional(-1, -0.98),
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: AlignmentDirectional(
                                              0.050000000000000044,
                                              0.050000000000000044),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.85, 0.85),
                                            child: IconButton(
                                              hoverColor: Colors.transparent,
                                              iconSize: 50,
                                              color: Color(0x00F8F8F8),
                                              icon: Icon(
                                                Icons.near_me_rounded,
                                                color: Color(0xFFF4F4F3),
                                                size: 28,
                                              ),
                                              onPressed: () {
                                                send();
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          )
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void send() async {
    PostModule post = PostModule(
      title: "Post",
      message: textController.text,
      groupimage: widget.group.image,
      image: imagepath,
      vedio: video,
      text: widget.group.onwername,
      date: Timestamp.now().toDate().toString(),
      type: imagepath.isEmpty
          ? video.isEmpty
              ? "T"
              : "V"
          : "I",
    );
    try {
      await FirebaseFirestore.instance
          .collection("groups")
          .doc(widget.group.name)
          .collection("posts")
          .add(post.toJson())
          .then((value) {
        print("okey");
        setState(() {
          imagepath = "";
          video = "";
          textController.clear();
        });
      });
    } catch (e) {}
  }
}

class Textcontainer extends StatefulWidget {
  final PostModule post;

  const Textcontainer({Key? key, required this.post}) : super(key: key);

  @override
  State<Textcontainer> createState() => _TextcontainerState();
}

class _TextcontainerState extends State<Textcontainer> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.post.date!);
    return Align(
      alignment: AlignmentDirectional(-0.05, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
              topLeft: Radius.circular(6),
              topRight: Radius.circular(4),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          widget.post.groupimage!,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              widget.post.text!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF616161),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              "Date: ${date.year}/${date.month}/${date.day}  at ${date.hour}:${date.minute}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF616161),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 10, 15, 15),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFFF5F5F5),
                    child: Text(
                      widget.post.message!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class imagecontainer extends StatefulWidget {
  final PostModule post;

  const imagecontainer({Key? key, required this.post}) : super(key: key);

  @override
  State<imagecontainer> createState() => _imagecontainerState();
}

class _imagecontainerState extends State<imagecontainer> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.post.date!);
    return Align(
      alignment: AlignmentDirectional(-0.05, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
              topLeft: Radius.circular(6),
              topRight: Radius.circular(4),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          widget.post.groupimage!,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              widget.post.text!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF616161),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              "Date: ${date.year}/${date.month}/${date.day}  at ${date.hour}:${date.minute}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF616161),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 10, 15, 15),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFFF5F5F5),
                    child: Text(
                      widget.post.message!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 10, 15, 15),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFFF5F5F5),
                    child: Image.network(
                      widget.post.image!,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class videocontainer extends StatefulWidget {
  final PostModule post;

  const videocontainer({Key? key, required this.post}) : super(key: key);

  @override
  State<videocontainer> createState() => _videocontainerState();
}

class _videocontainerState extends State<videocontainer> {
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.post.date!);
    return Align(
      alignment: AlignmentDirectional(-0.05, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
              topLeft: Radius.circular(6),
              topRight: Radius.circular(4),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          widget.post.groupimage!,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              widget.post.text!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF616161),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              "Date: ${date.year}/${date.month}/${date.day}  at ${date.hour}:${date.minute}",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF616161),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 10, 15, 15),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFFF5F5F5),
                    child: Text(
                      widget.post.message!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 10, 15, 15),
                  child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: Color(0xFFF5F5F5),
                      child: video_container(
                        video: widget.post.vedio!,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class video_container extends StatefulWidget {
  final String video;

  const video_container({Key? key, required this.video}) : super(key: key);

  @override
  State<video_container> createState() => _video_containerState();
}

class _video_containerState extends State<video_container> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      widget.video,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      VideoPlayer(_controller),
                      ClosedCaption(text: _controller.value.caption.text),
                      _ControlsOverlay(controller: _controller),
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                            bufferedColor: Colors.blue,
                            playedColor: Colors.red,
                            backgroundColor: Colors.grey),
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration(milliseconds: 0),
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
            setState(() {});
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: widget.controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              setState(() {
                widget.controller.setCaptionOffset(delay);
              });
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration
                    in _ControlsOverlay._exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text(
                '${widget.controller.value.captionOffset.inMilliseconds}ms',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: widget.controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              setState(() {
                widget.controller.setPlaybackSpeed(speed);
              });
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed
                    in _ControlsOverlay._examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text(
                      '${speed}x',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text(
                '${widget.controller.value.playbackSpeed}x',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
