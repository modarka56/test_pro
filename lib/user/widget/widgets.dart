import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class InputField extends StatelessWidget {
  final String hint;
  final validator;
  final Icon icon;
  final suffixIcon;
  final obscureText;
  final TextEditingController?controller;
  final Widget?widget;
  final ValueChanged<String>? onChanged;

  const InputField({Key? key,
    required this.hint,
    this.controller,
    this.widget,
    required this.icon,
    required this.validator,
    this.suffixIcon,
    this.obscureText, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator:validator,
onChanged: onChanged,
                  obscureText:obscureText,
                  controller: controller,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(

                    hintText: hint,
                    prefixIcon: icon,
                    suffixIcon: suffixIcon,
                  ),
                ),

              ),
              widget==null?Container():Container(child: widget,),
            ],
          ),
      ],
    ),
    );
  }
}
