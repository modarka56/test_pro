import"package:flutter/material.dart";
import 'package:test66/components/widget_exercise.dart';
import 'package:test66/user/models/data_exercise.dart';
import 'package:test66/user/widget/exercise_details.dart';

import '../models/User_model.dart';
class SpeedExercises extends StatelessWidget {
  final List basic;
  final UserModel user;
  const SpeedExercises({Key? key, required this.basic, required this.user, }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
        child: ListView.builder(
          itemCount: basic.length,
          itemBuilder: (BuildContext context, int index) {
            final exerciseSpeed = ExrciesModule.fromJson(basic[index].data());
            if(exerciseSpeed.type=="speed" && exerciseSpeed.level!<=user.level){
              return WidgetExercise(
                  exerciseName:  exerciseSpeed.exerciseName!,
                  ExerciseImage: exerciseSpeed.urlImage!,
                  levelExercise: exerciseSpeed.level!,
                  widget: DetilsWidget(exerciseSpeed.urlVideo!,
                      exerciseSpeed.exerciseName!,
                      exerciseSpeed.level!,
                      exerciseSpeed.details!, id: exerciseSpeed.id!, email: user.email,time: exerciseSpeed.numberOfTraining!,exrid: basic[index].id));
            }else{
              return Container();
            }
          },
        ),

      ),

    );
  }
}
