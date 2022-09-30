import 'package:flutter/material.dart';

class join_group extends StatefulWidget {
  const join_group({Key? key}) : super(key: key);

  @override
  State<join_group> createState() => _join_groupState();
}

class _join_groupState extends State<join_group> {
  late TextEditingController textController;
final scaffoldKey = GlobalKey<ScaffoldState>();

@override
void initState() {
  super.initState();
  textController = TextEditingController();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    key: scaffoldKey,
    appBar: AppBar(
      backgroundColor: Colors.black,
      automaticallyImplyLeading: true,
      actions: [],
      centerTitle: false,
      elevation: 2,
    ),
    backgroundColor: Colors.black,
    body: SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Stack(
            children: [
              Image.asset(
                'assets/images/1655788853944.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
              Align(
                alignment: AlignmentDirectional(0, -1),
                child: Material(
                  color: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 5),
                      child: TextFormField(
                        controller: textController,

                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'search group',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF262D34),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF262D34),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF95A1AC),
                          ),
                        ),
                        style:
                        TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF95A1AC),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
