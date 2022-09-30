import 'dart:io';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/models/postp_module.dart';
import 'package:video_player/video_player.dart';

import 'models/groupinfo_module.dart';

class Video_List extends StatefulWidget {
  final String email;
  final UserModel user;
  final GroupinfoModule group;

  const Video_List({Key? key, required this.email, required this.user, required this.group})
      : super(key: key);

  @override
  State<Video_List> createState() => _Video_ListState();
}

class _Video_ListState extends State<Video_List> {
  List videos = [];
  List all=[];
  String video = "";
  late File videoo;
  late UserModel user;
  bool pickvideo = false;
  bool upgrade=false;
  TextEditingController textController = TextEditingController();

  bool isloading = false;

  @override
  void initState() {
    getplayer();
    getvideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: upgrade?FloatingActionButton(
        onPressed: (){
upgradelevel();
        },
        child: Icon(CupertinoIcons.arrow_up_circle_fill),
      ):Container(),
      backgroundColor: Colors.black,
      appBar: AppBar(

        title: Text(
          "Videos",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, fontFamily: "arial",),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 4,
                child: ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    PostpModule post =
                        PostpModule.fromJson(videos[index].data());
                    return videocontainer(
                      user: widget.user,
                      post: post,
                      group: widget.group, email: widget.email,id: videos[index].id, player: user,
                    );
                  },
                ),
              ),
              widget.email == widget.user.email
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
                                              if (pickvideo) {
                                                send();
                                              } else {
                                                var snackBar = SnackBar(
                                                  elevation: 0,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content:
                                                      AwesomeSnackbarContent(
                                                    title: 'Warning',
                                                    message:
                                                        "You must pick a video to post it ",
                                                    contentType:
                                                        ContentType.warning,
                                                  ),
                                                );

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
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
        ],
      ),
    );
  }

  getvideos() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.email)
        .collection("videos").orderBy("date")
        .snapshots()
        .listen((event) {
      setState(() {
        videos = event.docs.sublist(event.docs.length-10,);
        all=event.docs;
        if(widget.user.type=="coach"&&widget.user.email==widget.group.email){
          upgradeplayer();
        }
      });
      print(videos);
    });
  }
   upgradeplayer(){
    int sum=0;
    int x=(user.level+1)*10;
print(x);
    switch(x){
      case 10:{
        if(all.length<x){
          break;
        }
        for(int i=0;i<10;i++){
          if(!all[i].get("rated")){
            setState(() {
              upgrade=false;
            });
          }else{double r=all[i].get("rating");
          sum=sum+r.toInt();
          }
        }
        var avrage=sum/x;
        print(avrage);
        if(avrage.toInt()>=6){
          setState(() {
            upgrade=true;
          });
        }
      }


        break;
      case 20:{
        if(all.length<x){
          break;
        }
        for(int i=0;i<20;i++){
          if(!all[i].get("rated")){
            setState(() {
              upgrade=false;
            });
          }else{double r=all[i].get("rating");
          sum=sum+r.toInt();
          }

        }
        if(sum>=6){
          setState(() {
            upgrade=true;
          });
        }
      }


        break;
      case 30:{
        if(all.length<x){
          break;
        }
        for(int i=0;i<30;i++){
          if(!all[i].get("rated")){
            setState(() {
              upgrade=false;
            });
          }else{double r=all[i].get("rating");
          sum=sum+r.toInt();
          }
        } if(sum>=6){
          setState(() {
            upgrade=true;
          });
        }
      }


        break;
      case 40:{
        if(all.length<x){
          break;
        }
        for(int i=0;i<40;i++){
          if(!all[i].get("rated")){
            setState(() {
              upgrade=false;
            });
          }else{double r=all[i].get("rating");
          sum=sum+r.toInt();
          }
        } if(sum>=6){
          setState(() {
            upgrade=true;
          });
        }
      }


        break;
      case 50:{
        if(all.length<x){
          break;
        }
        for(int i=0;i<50;i++){
          if(!all[i].get("rated")){
            setState(() {
              upgrade=false;
            });
          }else{double r=all[i].get("rating");
          sum=sum+r.toInt();
          }
        } if(sum>=6){
          setState(() {
            upgrade=true;
          });
        }
      }


        break;
      case 60:{
        if(all.length<x){
          break;
        }
        for(int i=0;i<60;i++){
          if(!all[i].get("rated")){
            setState(() {
              upgrade=false;
            });
          }else{double r=all[i].get("rating");
          sum=sum+r.toInt();
          }
        } if(sum>=6){
          setState(() {
            upgrade=true;
          });
        }
      }


        break;
      case 70:{
        if(all.length<x){
          break;
        }
        for(int i=0;i<70;i++){
          if(!all[i].get("rated")){
            setState(() {
              upgrade=false;
            });
          }else{double r=all[i].get("rating");
          sum=sum+r.toInt();
          }
        } if(sum>=6){
          setState(() {
            upgrade=true;
          });
        }
      }


        break;
      case 80:
       {
         if(all.length<x){
           break;
         }
         for(int i=0;i<80;i++){
           if(!all[i].get("rated")){
             setState(() {
               upgrade=false;
             });
           }else{double r=all[i].get("rating");
           sum=sum+r.toInt();
           }
         } if(sum>=6){
           setState(() {
             upgrade=true;
           });
         }
       }

        break;
      case 90:{
        if(all.length<x){
          break;
        }
        for(int i=0;i<90;i++){
          if(!all[i].get("rated")){
            setState(() {
              upgrade=false;
            });
          }else{double r=all[i].get("rating");
          sum=sum+r.toInt();
          }
        }
        if(sum>=6){
          setState(() {
            upgrade=true;
          });
        }
      }


        break;

      default: {
        print("master");
      }
      break;
    }
  }
getplayer(){
  FirebaseFirestore.instance
      .collection("users")
      .doc(widget.email)
      .snapshots()
      .listen((event) {
    setState(() {
       user = UserModel.fromJson(event.data()!);


    });
  });

}
  void send() async {
    await _uploadvideoToFirebase(videoo).then((value) {
      PostpModule post = PostpModule(
          title: user.name,
          message: textController.text.trim(),
          video: video,
          date: Timestamp.now().toDate().toString(),
          rating: 0,
      rated: false);
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.email)
          .collection("videos")
          .doc()
          .set(post.toJson())
          .then((value) {
            setState(() {
              pickvideo=false;
              textController.clear();
            });
      });
    });
  }

  Future getVideo() async {
    // Get image from gallery.
    setState(() {
      isloading = true;
    });
    var pickedfile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    videoo = File(pickedfile!.path);
    setState(() {
      pickvideo = true;
      isloading = false;
    });
    // _uploadvideoToFirebase(videoo);
  }

  Future<void> _uploadvideoToFirebase(File image) async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      String imageLocation =
          'videos/profiles/${user.email}/vid${randomNumber}.mp4';
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

  void upgradelevel() async{
    await FirebaseFirestore.instance.collection("users").doc(widget.email).update({"level":user.level+1}).then((value){
      setState(() {
        upgrade=false;
      });
    });
  }
}

// class VideoCapsoule extends StatefulWidget {
//   const VideoCapsoule({Key? key}) : super(key: key);
//
//   @override
//   State<VideoCapsoule> createState() => _VideoCapsouleState();
// }
//
// class _VideoCapsouleState extends State<VideoCapsoule> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         width: 200,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
//         child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20), color: Colors.red),
//             child: Stack(children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image(
//                   width: 200,
//                   image: AssetImage("assets/11.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.only(left: 5),
//                   decoration: ShapeDecoration(
//                       color: Colors.black, shape: CircleBorder()),
//                   child: FaIcon(
//                     FontAwesomeIcons.play,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//               )
//             ])),
//       ),
//     );
//   }
// }
class videocontainer extends StatefulWidget {
  final PostpModule post;
  final UserModel user;
  final GroupinfoModule group;
  final String email;
  final String id;
  final UserModel player;

  const videocontainer({Key? key, required this.post, required this.user, required this.group, required this.email, required this.id, required this.player, }) : super(key: key);

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
                          widget.player.image,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                            child: Text(
                              widget.post.title!,
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
                        video: widget.post.video!,
                      )),
                ),
                widget.user.email==widget.group.email?widget.user.type=="coach"?Center(
                  child: RatingBar.builder(
                    itemSize: 25,
                    initialRating: widget.post.rating!,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 10,
                    ignoreGestures: widget.post.rated!,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.red.shade900,

                    ),
                    onRatingUpdate: (rating) async{
await FirebaseFirestore.instance.collection("users").doc(widget.email).collection("videos").doc(widget.id).update({"rating":rating,"rated":true}).then((value){

});
                      print(rating);
                    },

                  ),
                ):Container():Container()
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

  const video_container({Key? key, required this.video,})
      : super(key: key);

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
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: double.infinity,

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
              : Container(child: Center(child: CircularProgressIndicator(),),),
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
                  '${widget.controller.value.captionOffset.inMilliseconds}ms'),
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
                    child: Text('${speed}x'),
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
              child: Text('${widget.controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
