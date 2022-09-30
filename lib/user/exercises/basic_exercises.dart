
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test66/components/widget_exercise.dart';
import 'package:test66/user/detales_exr_co.dart';
import 'package:test66/user/models/data_exercise.dart';
import 'package:test66/user/widget/exercise_details.dart';

import '../models/User_model.dart';
class ExerciseWidget extends StatelessWidget {
  final List basic;
  final UserModel user;
  const ExerciseWidget({Key? key, required this.basic, required this.user, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(

      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
        child: ListView.builder(
          itemCount: basic.length,
          itemBuilder: (BuildContext context, int index) {
            final exerciseBasic = ExrciesModule.fromJson(basic[index].data());
            if(exerciseBasic.type=="basic"&& exerciseBasic.level!<=user.level) {
              return WidgetExercise(
                  exerciseName:  exerciseBasic.exerciseName!,
                  ExerciseImage: exerciseBasic.urlImage!,
                  levelExercise: exerciseBasic.level!,
                  widget: DetilsWidget(exerciseBasic.urlVideo!,
                      exerciseBasic.exerciseName!,
                      exerciseBasic.level!,
                  exerciseBasic.details!, id: exerciseBasic.id!,email: user.email, time: exerciseBasic.numberOfTraining!, exrid: basic[index].id, ));
            }else{
              return Container();
            }
          },
        ),

      ),

    );
  }
}

