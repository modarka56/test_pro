import 'package:flutter/material.dart';
import 'package:test66/components/widget_exercise.dart';
import 'package:test66/user/models/data_exercise.dart';
import 'package:test66/user/widget/exercise_details.dart';

import '../models/User_model.dart';
class FitenssExercises extends StatelessWidget {
  final List basic;
  final UserModel user;
  const FitenssExercises({Key? key, required this.basic, required this.user,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
        child: ListView.builder(
          itemCount: basic.length,
          itemBuilder: (BuildContext context, int index) {
            final exerciseFitenss = ExrciesModule.fromJson(basic[index].data());
            if(exerciseFitenss.type=="fitnece"&& exerciseFitenss.level!<=user.level){
              return WidgetExercise(
                  exerciseName:  exerciseFitenss.exerciseName!,
                  ExerciseImage: exerciseFitenss.urlImage!,
                  levelExercise: exerciseFitenss.level!,
                  widget: DetilsWidget(exerciseFitenss.urlVideo!,
                      exerciseFitenss.exerciseName!,
                      exerciseFitenss.level!,
                      exerciseFitenss.details!, id: exerciseFitenss.id!, email: user.email, time: exerciseFitenss.numberOfTraining!,exrid: basic[index].id));
            }else{
              return Container();
            }
          },
        ),

      ),

    );
  }
}
