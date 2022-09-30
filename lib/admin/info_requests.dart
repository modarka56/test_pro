import 'package:flutter/material.dart';
class InfoRequaste extends StatefulWidget{
  @override
  State<InfoRequaste> createState() => _InfoRequaste();
}
class _InfoRequaste extends State<InfoRequaste> {
  @override
  Widget build(BuildContext context) =>
      DefaultTabController(
       length: 2,
        child:
        Scaffold(
            appBar: AppBar(
            backgroundColor: Color(0xFF1B1000),
        automaticallyImplyLeading: false,
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Page Title',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
            body: Text("hiba")) ,
      );
}