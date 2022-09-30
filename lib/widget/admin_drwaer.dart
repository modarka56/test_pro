import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/admin/Logs.dart';
import 'package:test66/admin/home_page.dart';
import 'package:test66/admin/sub_admin_page.dart';
import 'package:test66/user/models/Admin_module.dart';

import '../admin/Report_page.dart';
import '../user/login_page.dart';
import '../user/models/User_model.dart';
import '../user/program.dart';
import '../user/program_co.dart';
import '../user/user_profile.dart';

class admin_drwaer extends StatefulWidget {
  final AdminModule user;

  const admin_drwaer({Key? key, required this.user}) : super(key: key);

  @override
  State<admin_drwaer> createState() => _admin_drwaerState();
}

class _admin_drwaerState extends State<admin_drwaer> {
  Widget Iconss(Icons, textIcon, actions) {
    return InkWell(
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
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 60, 0, 0),
            child: Image.asset(
              'assets/Taekowndo2.png',
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.06,
              fit: BoxFit.fill,
            ),
          ),
          Divider(
            endIndent: 10,
            color: Color(0xFF757575),
          ),
          Iconss(
            Icons.home,
            "Home",
            () {
              Get.to(() => HomePage(admin: widget.user));
            },
          ),
          widget.user.type == "admin"
              ? Iconss(
                  Icons.person,
                  'add_subadmin',
                  () {
                    Get.to(() => sub_adminpage());
                  },
                )
              : Container(),
          widget.user.type == "admin"
              ? Iconss(
                  Icons.library_books_sharp,
                  'Logs',
                  () {
                    Get.to(() => Logs(),
                        transition: Transition.leftToRight,
                        duration: Duration(milliseconds: 1500),
                        fullscreenDialog: false);
                  },
                )
              : Container(),
          Iconss(
            Icons.report,
            'Exrcies Report'
                ,
            () {
              Get.to(()=>report_page());
            },
          ),
          Iconss(
            Icons.history_edu,
            'History of taekwondo',
            () {
              print('IconButton pressed ...');
            },
          ),
          Iconss(
            Icons.help_outline,
            'Help',
            () {
              print('IconButton pressed ...');
            },
          ),
          Iconss(
            Icons.logout_rounded,
            'Logout',
            () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              await FirebaseAuth.instance.signOut().then((value) {
                Get.off(() => Login());
              });
            },
          ),
        ],
      ),
    );
  }
}
