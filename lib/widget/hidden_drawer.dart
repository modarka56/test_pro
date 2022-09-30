import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:test66/admin/home_page.dart';
import 'package:test66/admin/info_requests.dart';
class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages=[];
  @override
  void initState() {
    super.initState();
    _pages = [
//       ScreenHiddenDrawer(
//
// ItemHiddenMenu(
//   name: "Homepage",
//   baseStyle: TextStyle(),
//   selectedStyle: TextStyle(),
//   ),
//         HomePage(),
//
//       ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
         name: "Info",
         baseStyle: TextStyle(),
         selectedStyle: TextStyle(),
    ),
    InfoRequaste(),
    ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.indigoAccent,
      screens: _pages,
      initPositionSelected: 0,
    );
  }
}
