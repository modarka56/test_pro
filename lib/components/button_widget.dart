import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class IconButtonWidget extends StatelessWidget {
  final icon;
  const IconButtonWidget({Key? key,
    required this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.transparent,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.14,
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(0xFFBDBDBD),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Colors.black,
          size: 45,
        ),
      ),
    );
  }
}
class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({Key? key,
    required this.level, this.width, this.height
  }) : super(key: key);
final String level;
final width;
final height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ,
      height: height ,
      decoration: BoxDecoration(
        color: Color(0xFFEEEEEE),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color(0xFFBDBDBD),
          )
        ],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Align(
        alignment: AlignmentDirectional(-0.05, -0.05),
        child: Text(
          ' ${level}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
