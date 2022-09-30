import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Daily_exrcies extends StatefulWidget {
  const Daily_exrcies({Key? key}) : super(key: key);

  @override
  State<Daily_exrcies> createState() => _Daily_exrciesState();
}

class _Daily_exrciesState extends State<Daily_exrcies> {
  List dp=[];

  @override
  void initState() {
    getprogram();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: 2,itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.blue,
        ),
      );
    });
  }

  void getprogram()async {
    await FirebaseFirestore.instance.collection("users").doc("memo1@gmail.com").collection("dp").snapshots().listen((event) {
      setState(() {
        dp=event.docs;
      });
    });
  }
}
