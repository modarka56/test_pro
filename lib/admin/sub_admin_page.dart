import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test66/admin/add_subadmin.dart';
import 'package:test66/user/models/Admin_module.dart';


class sub_adminpage extends StatefulWidget {
  const sub_adminpage({Key? key}) : super(key: key);

  @override
  State<sub_adminpage> createState() => _sub_adminpageState();
}

class _sub_adminpageState extends State<sub_adminpage> {
  List sub=[];

  @override
  void initState() {
   getsub();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub AdminPage"),
      
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(()=>AddSubadmin(users: sub,));
      } ,
      child: Center(child: Icon(Icons.add),)
      ,),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: sub.length,
        itemBuilder: (context, index) {
          if(sub[index].get("type")=="subadmin"){
            AdminModule requ =  AdminModule.fromJson(sub[index].data()!);

              return Container(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: 100,
                      height: MediaQuery.of(context).size.height * 0.12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Color(0xFFD4D1D1),
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 7),
                          Material(
                            color: Colors.transparent,
                            elevation: 8,
                            shape: const CircleBorder(),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Color(0xFF9296f0),
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                  width: 70,
                                  height: 70,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    "assets/avatar.png",
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),

                              Align(
                                alignment: AlignmentDirectional(-0.44, -0.72),
                                child: Text(
                                  'Name : ${requ.name}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(-0.48, -0.17),
                                child: Text(
                                  'Email : ${requ.email}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }else{
            return Container();
          }

        },
      )
    );
  }

  void getsub() async{
    FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      setState(() {
        sub=event.docs;
      });
    });
  }
}
