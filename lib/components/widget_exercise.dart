import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WidgetExercise extends StatefulWidget {
  final String ExerciseImage;
  final String exerciseName;
  final Widget widget;
  final int levelExercise;

  const WidgetExercise(
      {Key? key,
      required this.ExerciseImage,
      required this.exerciseName,
      required this.widget,
      required this.levelExercise})
      : super(key: key);

  @override
  State<WidgetExercise> createState() => _WidgetExerciseState();
}

class _WidgetExerciseState extends State<WidgetExercise> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(1, 0.5, 0.5, 0.5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      widget.ExerciseImage,
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.height * 0.11,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Text(
                      widget.exerciseName,
                      style: TextStyle(
                        color: Color(0xFFFFEBEE),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    'Level :${widget.levelExercise}',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Get.to(() => widget.widget,
                      transition: Transition.cupertino,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeIn,
                      );

                },
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Color(0x65EEEEEE),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(110, 0, 0, 25),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.002,
            decoration: BoxDecoration(
              color: Color(0x35EEEEEE),
            ),
          ),
        ),
      ],
    );
  }
}
