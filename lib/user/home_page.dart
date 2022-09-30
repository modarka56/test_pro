import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test66/Creat_group.dart';
import 'package:test66/user/Wating_page.dart';
import 'package:test66/user/exercises/basic_exercises.dart';
import 'package:test66/user/exercises/fitenss_exercises.dart';
import 'package:test66/user/exercises/power_exercises.dart';
import 'package:test66/user/exercises/speed_execises.dart';
import 'package:test66/user/ingroup.dart';
import 'package:test66/user/join_group.dart';
import 'package:test66/user/models/User_model.dart';
import 'package:test66/user/models/groupinfo_module.dart';
import 'package:test66/user/notfication_page.dart';
import 'package:test66/user/program.dart';
import 'package:test66/user/user_profile.dart';
import 'package:test66/widget/drawer.dart';

import '../search_group.dart';
import 'group.dart';

class HomePageWidget extends StatefulWidget {
  final int id;

  const HomePageWidget({Key? key, required this.id}) : super(key: key);
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> all = [];
  bool hide = false;
  late PersistentTabController _controller;
  UserModel user = UserModel(
    name: "",
    phone: "",
    age: 0,
    lastonline: Lastonline(),
    online: false,
    image: "",
    email: "",
    password: "",
    level: 0,
    hight: 0,
    weight: 0,
    sex: "",
    country: "",
    type: "",
    musclesinjured: [],
    ingroup: "",
    groupid: "",
  );
  GroupinfoModule group = GroupinfoModule(
      email: '',
      name: '',
      level: '',
      onwername: '',
      bio: '',
      image: '');

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(
            CupertinoIcons.search,
          ),
          title: ("Search"),
          textStyle: TextStyle(
              inherit: false,
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          activeColorSecondary: CupertinoColors.black,
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: CupertinoColors.white,
          onPressed: (context) {
            setState(() {
              _controller.jumpToTab(0);
            });
          }),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          textStyle: TextStyle(
              inherit: false,
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          activeColorPrimary: CupertinoColors.white,
          activeColorSecondary: Colors.black,
          inactiveColorPrimary: CupertinoColors.white,
          onPressed: (context) {
            setState(() {
              _controller.jumpToTab(1);
            });
          }),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person_alt_circle),
          title: ("Profile"),
          textStyle: TextStyle(
              inherit: false,
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          activeColorSecondary: CupertinoColors.black,
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: CupertinoColors.white,
          onPressed: (context) {
            setState(() {
              _controller.jumpToTab(2);
            });
          }),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person_3_fill),
          title: ("Group"),
          textStyle: TextStyle(
              inherit: false,
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          activeColorSecondary: CupertinoColors.black,
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: CupertinoColors.white,
          onPressed: (context) {
            setState(() {
              _controller.jumpToTab(3);
            });
          }),
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.bell_fill),
          title: ("Home"),
          textStyle: TextStyle(
              inherit: false,
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          activeColorPrimary: CupertinoColors.white,
          activeColorSecondary: Colors.black,
          inactiveColorPrimary: CupertinoColors.white,
          onPressed: (context) {
            setState(() {
              _controller.jumpToTab(4);
            });
          }),
    ];
  }

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: widget.id);
    getuser();
    getprogram();
    super.initState();
  }

  getuser() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      user = UserModel.fromJson(json.decode(pref.getString("user")!));
    });
    if (user.groupid.isNotEmpty) {
      getgroup();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // getexrcies() async {
  //   await FirebaseFirestore.instance
  //       .collection("exercies")
  //       .snapshots()
  //       .listen((event) {
  //     setState(() {
  //       all = event.docs;
  //     });
  //   });
  // }

  getgroup() async {
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(user.groupid)
        .get()
        .then((value) {
      setState(() {
        group = GroupinfoModule.fromJson(value.data()!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(user.toJson());
    // print(group.toJson());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(_navBarsItems()[_controller.index].title!),
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  hide = !hide;
                });
              },
              icon: !hide
                  ? Icon(CupertinoIcons.arrow_down)
                  : Icon(CupertinoIcons.arrow_up))
        ],
      ),
      drawer: WidgetDrawer(user: user,),
      body: PersistentTabView(
        context,

        controller: _controller,
        hideNavigationBar: hide,
        screens: [
          search_group(
            fromnav: true,
          ),
          // program(user: user,),
          exrciece_page(
            user: user,
            pro: all,
          ),
          ProfileWidget(
            email: user.email,
            fromnav: true,
          ),
          // notification_page( email: user.email!)
          user.type == "player" ? user.ingroup == "pendding"
              ? Wating_page()
              : user.ingroup == "yes"
              ? GroupWidget(
            group: group,
            user: user,
          )
              : Container(
            child: Center(
              child: GestureDetector(
                  onTap: () {
                    _controller.jumpToTab(0);
                  },
                  child: Text("join")),
            ),
          ) : user.ingroup == "pendding" ? Wating_page() : user.ingroup == "yes"
              ? GroupWidget(group: group, user: user):CreateGroupWidget(),
          // GroupWidget(group: group!,user: user!,)
          notification_page(email: user.email)
        ],

        items: _navBarsItems(),

        bottomScreenMargin: 0,

        confineInSafeArea: true,

        margin: EdgeInsets.only(left: 10, bottom: 15, right: 10),

        backgroundColor: Colors.black,

        // Default is Colors.white.

        handleAndroidBackButtonPress: true,

        // Default is true.

        resizeToAvoidBottomInset: true,

        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.

        stateManagement: true,

        // Default is true.
        onItemSelected: (i) {
          setState(() {});
        },

        hideNavigationBarWhenKeyboardShows: true,

        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),

        popAllScreensOnTapOfSelectedTab: true,

        popActionScreens: PopActionScreensType.all,

        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.

          duration: Duration(milliseconds: 1000),

          curve: Curves.ease,
        ),

        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.

          animateTabTransition: true,

          curve: Curves.fastOutSlowIn,

          duration: Duration(milliseconds: 1000),
        ),

        navBarStyle:
        NavBarStyle.style7, // Choose the nav bar style with this property.
      ),
    );
  }

  void getprogram() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      all = pref.getStringList("pro")!;
    });
    print(all);
  }
}

class exrciece_page extends StatefulWidget {
  const exrciece_page({Key? key, required this.user, required this.pro})
      : super(key: key);
  final UserModel user;
  final List<String> pro;

  @override
  State<exrciece_page> createState() => _exrciece_pageState();
}

class _exrciece_pageState extends State<exrciece_page> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List all = [];
  List value = [];
  bool issave = false;

  // UserModel user = UserModel(
  //     name: "",
  //     phone: "",
  //     age: 0,
  //     lastonline: Lastonline(),
  //     online: false,
  //     image: "",
  //     email: "",
  //     password: "",
  //     level: 0,
  //     hight: 0,
  //     weight: 0,
  //     sex: "",
  //     country: "",
  //     type: "",
  //     musclesinjured: [],
  //     ingroup: "",
  //     groupid: "",
  //     );
  @override
  void initState() {
    getexrcies();

    // getuser();
    super.initState();
  }

  @override
  void dispose() {
    print("dis");
    super.dispose();
  }

  getexrcies() async {
    await FirebaseFirestore.instance
        .collection("exercies")
        .snapshots()
        .listen((event) {
      setState(() {
        all = event.docs;
      });
    });
  }

  // getuser() async {
  //   final pref = await SharedPreferences.getInstance();
  //
  //
  //
  //     setState(() {
  //       user = UserModel.fromJson(json.decode(pref.getString("user")!));
  //     });
  //
  //
  //
  // }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF060606),
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Exercises',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          actions: [
            widget.pro.length <= 5 && widget.pro.isNotEmpty
                ? IconButton(
                onPressed: () {
                  if (issave) {
                    var snackBar = SnackBar(
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Oh snap ',
                        message:
                        "you save your program for today",
                        contentType: ContentType.warning,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    save();
                  }
                },
                icon: Icon(CupertinoIcons.checkmark_alt_circle))
                : Container()
          ],
          centerTitle: false,
          elevation: 0,
        ),
        backgroundColor: Color(0xFF060606),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color(0xFF2e2e2e)],
                    stops: [0.0, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(children: [
                  TabBar(
                    padding: EdgeInsets.only(top: 10, left: 5),
                    indicatorWeight: 25,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFFFC0004), Color(0xFF7E0404)]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    tabs: [
                      Tab(
                          child: Align(
                              alignment: AlignmentDirectional(0, 0.8),
                              child: Text(
                                'Basic',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                      Tab(
                          child: Align(
                              alignment: AlignmentDirectional(0, 0.8),
                              child: Text(
                                'Speed',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                      Tab(
                          child: Align(
                              alignment: AlignmentDirectional(0, 0.8),
                              child: Text(
                                'Fitenss',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                      Tab(
                          child: Align(
                              alignment: AlignmentDirectional(0, 0.8),
                              child: Text(
                                'Power',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.002,
                      decoration: BoxDecoration(
                        color: Color(0x31EEEEEE),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ExerciseWidget(
                          basic: all,
                          user: widget.user,
                        ),
                        SpeedExercises(
                          basic: all,
                          user: widget.user,
                        ),
                        FitenssExercises(
                          basic: all,
                          user: widget.user,
                        ),
                        PowerExercises(
                          basic: all,
                          user: widget.user,
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void save() async {
    try {
      for (int i = 0; i < widget.pro.length; i++) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(widget.user.email)
            .collection("dp")
            .doc(i.toString())
            .set({"id": widget.pro[i]}).then((value) {
          print("hey");
        });
      }
      issave = true;
    } catch (e) {

    }
  }

}
