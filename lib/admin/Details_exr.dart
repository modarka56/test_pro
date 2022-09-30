import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test66/user/models/data_exercise.dart';
import 'package:video_player/video_player.dart';

import '../components/button_widget.dart';

class Detalis_exr extends StatefulWidget {
  final ExrciesModule exr;
  const Detalis_exr({Key? key, required this.exr}) : super(key: key);

  @override
  State<Detalis_exr> createState() => _Detalis_exrState();
}

class _Detalis_exrState extends State<Detalis_exr> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<void> _initializeVideoPlayerFuture;
  late VideoPlayerController controller;


  @override
  void initState() {
    controller = VideoPlayerController.network(widget.exr.urlVideo!);
    _initializeVideoPlayerFuture = controller.initialize();


    controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    print("heye");

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
          'Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 32,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: Align(
          alignment: AlignmentDirectional(0.82, -0.21),
          child: FloatingActionButton(
            child: Icon(
              controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 30,
            ),
            backgroundColor: Colors.grey,
            onPressed: () {
              setState(() {
                if (controller.value.isPlaying) {
                  controller.pause();
                } else {
                  controller.play();
                }
              });
            },
          )),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFF595858)],
            stops: [0.4, 1],
            begin: AlignmentDirectional(0, -1),
            end: AlignmentDirectional(0, 1),
          ),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(-0.2, -0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'exercise duration',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      widget.exr.numberOfTraining!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.9, 0.2),
                child: TextButtonWidget(
                  level: "Level ${widget.exr.level}",
                  width: MediaQuery.of(context).size.width * 0.32,
                  height: MediaQuery.of(context).size.height * 0.044,
                ),
              ),


              Align(
                alignment: AlignmentDirectional(-0.85, -0.29),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.black,
                  child: Text(
                    widget.exr.exerciseName!,
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.9, -0.05),
                child: IconButtonWidget(
                  icon: Icons.timer_sharp,
                ),
              ),
              GestureDetector(
                onTap: () => _showBottomSheet(),
                child: Align(
                  alignment: AlignmentDirectional(0, 1),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.14,
                      decoration: BoxDecoration(
                        color: Color(0xFFE0E0E0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7,
                            color: Color(0xFFBDBDBD),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        border: Border.all(
                          color: Color(0xFFD6D6D6),
                          width: 0,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.02, -0.2),
                            child: Text(
                              'Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.02, -0.5),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Container(
                                width: 100,
                                height:
                                MediaQuery.of(context).size.height * 0.007,
                                constraints: BoxConstraints(
                                  maxHeight:
                                  MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.01),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showBottomSheet() {
    Get.bottomSheet(
      Align(
        alignment: AlignmentDirectional(0, 1),
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 7,
                  color: Color(0xFFBDBDBD),
                )
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              border: Border.all(
                color: Color(0xFFD6D6D6),
                width: 0,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(-0.02, -0.8),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 28,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.02, -0.9),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height * 0.007,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.015,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, -0.6),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 90, left: 15, right: 15),
                    child: Card(
                      elevation: 0,
                      color: Color(0xFFE0E0E0),
                      child: SingleChildScrollView(
                        child: Text(

                          widget.exr.details!,

                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          textDirection: TextDirection.ltr,
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
}
