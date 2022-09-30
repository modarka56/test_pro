import 'package:flutter/material.dart';
import 'package:test66/user/models/data_exercise.dart';
import 'package:test66/user/widget/exercise_details.dart';

import '../../components/widget_exercise.dart';
import '../models/User_model.dart';
class PowerExercises extends StatelessWidget {
  final List basic;
  final UserModel user;
  const PowerExercises({Key? key, required this.basic,  required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
        child: ListView.builder(
          itemCount: basic.length,
          itemBuilder: (BuildContext context, int index) {
            final exercisePower = ExrciesModule.fromJson(basic[index].data());
            if(exercisePower.type=="power"&& exercisePower.level!<=user.level) {
              return WidgetExercise(
                exerciseName:  exercisePower.exerciseName!,
                ExerciseImage: exercisePower.urlImage!,
                levelExercise: exercisePower.level!,
                  widget: DetilsWidget(exercisePower.urlVideo!,
                      exercisePower.exerciseName!,
                      exercisePower.level!,
                      exercisePower.details!, id: exercisePower.id!,email: user.email, time: exercisePower.numberOfTraining!,exrid: basic[index].id ));
            }else{
              return Container();
            }
          },
        ),

      ),

    );
  }
}
