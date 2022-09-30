
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';


class SettingsWidget extends StatefulWidget {
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late String dropDownValue1;
  late String dropDownValue2;
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  late String radioButtonValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    textController4 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xFFD50000),
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
     // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(95, 10, 0, 45),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.37,
                    height: MediaQuery.of(context).size.width * 0.37,
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/446/600',
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-0.81, 0.97),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.14,
                            height: MediaQuery.of(context).size.width * 0.14,
                            decoration: BoxDecoration(
                              color: Color(0xFFBDBDBD),
                              shape: BoxShape.circle,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(-1.05, 0.98),
                              child: Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(5, 0, 0, 7),
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: Color(0xFF171616),
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  controller: textController1,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Name ',
                    hintText: 'enter your name ',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 28,
                    ),
                    suffixIcon: textController1.text.isNotEmpty
                        ? InkWell(
                      onTap: () => setState(
                            () => textController1.clear(),
                      ),
                      child: Icon(
                        Icons.clear,
                        color: Color(0xFF757575),
                        size: 22,
                      ),
                    )
                        : null,
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: textController2,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'enter your age',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.cake,
                      ),
                      suffixIcon: textController2.text.isNotEmpty
                          ? InkWell(
                        onTap: () => setState(
                              () => textController2.clear(),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
                      )
                          : null,
                    ),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: textController3,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Ex : ....@gmail.com',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      suffixIcon: textController3.text.isNotEmpty
                          ? InkWell(
                        onTap: () => setState(
                              () => textController3.clear(),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
                      )
                          : null,
                    ),
                    style: TextStyle(),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: TextFormField(
                    controller: textController4,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'country',
                      hintText: 'the  country you live in',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.public,
                      ),
                      suffixIcon: textController4.text.isNotEmpty
                          ? InkWell(
                        onTap: () => setState(
                              () => textController4.clear(),
                        ),
                        child: Icon(
                          Icons.clear,
                          color: Color(0xFF757575),
                          size: 22,
                        ),
                      )
                          : null,
                    ),
                    style: TextStyle(),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.51,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            color: Color(0xFFBDBDBD),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButton(
                            focusColor: Color(0xFFBDBDBD),
                            elevation: 2,
                            dropdownColor: Color(0x005F5F5F),
                            items:<String> [
                              'foot injuries',
                              'ankle injuries',
                              'forearm injuies',
                              'Shoulder injuries',
                              'Injuries to the ribs and spine',
                              'Hip injury',
                              'nothing'
                            ].map<DropdownMenuItem<String>>((String value){
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value.toString()));
                            }).toList(),
                            hint: Text('injures', style: TextStyle(
                              color: Colors.black,
                            ),),
                            onChanged: (value) =>
                                setState(() => dropDownValue1 ),
                          ),
                        ),
                      ),/*
                      Container(
                        width: MediaQuery.of(context).size.width * 0.39,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: Color(0xFFBDBDBD),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: FlutterFlowDropDown(
                          options: ['Slinght', 'Medium', 'severe'].toList(),
                          onChanged: (val) =>
                              setState(() => dropDownValue2 = val),
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 50,
                          textStyle: TextStyle(
                            color: Colors.black,
                          ),
                          hintText: 'Injury severity',
                          fillColor: Color(0xFFBDBDBD),
                          elevation: 2,
                          borderColor: Color(0x003E3A3A),
                          borderWidth: 0,
                          borderRadius: 0,
                          margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                    */],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        Icons.vpn_key_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                        child: Text(
                          'change password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),/*
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                  child: FlutterFlowRadioButton(
                    options: ['Female', 'male'].toList(),
                    initialValue: 'Gender',
                    onChanged: (value) {
                      setState(() => radioButtonValue = value);
                    },
                    optionHeight: 25,
                    textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                    ),
                    selectedTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    buttonPosition: RadioButtonPosition.left,
                    direction: Axis.vertical,
                    radioButtonColor: Color(0xFF616161),
                    inactiveRadioButtonColor: Color(0xFF757575),
                    toggleable: false,
                    horizontalAlignment: WrapAlignment.start,
                    verticalAlignment: WrapCrossAlignment.start,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(100, 0, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Save',
                    options: FFButtonOptions(
                      width: 130,
                      height: 40,
                      color: Color(0xFF3E3A3A),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                ),
              */],
            ),
          ),
        ),
      ),
    );
  }
}
