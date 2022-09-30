import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/History.dart';
import 'package:test66/user/home_page.dart';
import 'package:test66/user/login_page.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/program.dart';
import 'package:test66/user/program_co.dart';
import 'package:test66/user/user_profile.dart';
class WidgetDrawer extends StatelessWidget{
 final UserModel user;

  WidgetDrawer({Key? key, required this.user}) : super(key: key);
  Widget Iconss(Icons,textIcon,actions){
    return   InkWell(
      onTap: actions,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons,
              color: Colors.black,
              size: 35,



            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
              child: Text(
                textIcon,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 60, 0, 0),
            child: Image.asset('assets/Taekowndo.png',
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.06,
              fit: BoxFit.fill,
            ),
          ),
          Divider(
            endIndent: 10,
            color: Color(0xFF757575),
          ),
          Iconss(Icons.person_outline,"Profile", () {
            Get.to(()=>ProfileWidget(email: user.email,fromnav: false,));
          },),
          Iconss(Icons.home,'group page', () {
            Get.off(()=>HomePageWidget(id: 1,),preventDuplicates: false);
          },),
          Iconss(Icons.date_range_outlined,'daily program', () {
            user.type=="player"?Get.to(()=>program(user: user,id: 0,)):Get.to(()=>program_co(user: user));

          },),
          user.type=="player"?Iconss(Icons.grid_view,'group exercises', () {
           Get.to(()=>program(user: user,id: 1));
          },):Container(),
          Iconss(Icons.search, 'search group',() {
            print('IconButton pressed ...');
          },),
          Iconss(Icons.settings,'setting', () {
            print('IconButton pressed ...');
          },),
          Iconss(Icons.history_edu,'History of taekwondo', () {
         Get.to(HistoryWidget());
          },),
          Iconss(Icons.help_outline,'Help', () {
            print('IconButton pressed ...');
          },),
          Iconss(Icons.logout_rounded,'Logout', () async{
            SharedPreferences pref=await SharedPreferences.getInstance();
            await pref.clear();
            await FirebaseAuth.instance.signOut().then((value) {
              Get.off(()=>Login());
            });

          },),
        ],
      ),
    );
  }

}