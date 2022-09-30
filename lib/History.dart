
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  PageController pageViewController=PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
@override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          'information about taekwondo',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 500,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                          child: PageView(
                            controller: pageViewController ??=
                                PageController(initialPage: 0),
                            scrollDirection: Axis.horizontal,
                            children: [
                              ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sports history',
                                        style:TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Text(
                                          'What is Taekwondo?',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3F51B5),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Text(
                                          'Taekwondo (/ˈtaɪˈkwɒnˈdoʊ/) is a Korean martial art with a heavy emphasis on kicks. Taekwondo was developed during the 1940s and 1950s by various Korean martial artists as a blend of the indigenous Korean fighting styles of taekkyeon, gwonbeop, and subak, with influence from foreign martial arts, such as karate and Chinese martial arts.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 8, 0, 0),
                                        child: Text(
                                          'The oldest governing body for Taekwondo is the Korea Taekwondo Association (KTA), formed in 1959 by a collaborative effort by representatives from the nine original kwans, or martial arts schools, in Korea. The main international organizational bodies for Taekwondo today are the International Taekwon-Do Federation (ITF), founded by General Choi Hong Hi in 1966, and the World TaeKwonDo Federation (WTF), founded in 1973 by the KTA. Gyeorugi ([kjʌɾuɡi]), a type of full-contact sparring, has been an Olympic event since 1992. The body known for taekwondo in the Olympics is the World TaeKwonDo Federation.',
                                          style:TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Taekwondo rules',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Text(
                                          'Equipment and facilities',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3949AB),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Taekwondo is a combat sport between two fighters in the same weight category.\n\nThe centre of the competition area is octagonal-shaped and measures 8m in diameter.\n\nContestants must wear a dobok or a white competition uniform.\n\nAdditionally, they must have a trunk protector, head protector and, for male athletes, a groin guard that is worn under the dobok.\n\nThe taekwondoin must also be equipped with forearm and shin guards, gloves, sensing socks, and a mouth guard before entering the competition area.\n\nHead protection is usually firmly tucked under left arms when entering into the competition area and is worn when instructed by the referee.',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Scoring',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3949AB),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'Scoring of a valid point or points is determined primarily using the electronic scoring system installed in the head or trunk protectors, known as the Protector and Scoring Systems (PSS).\n\nPoints awarded for punching techniques and additional points awarded for turning kicks are scored by judges using manual scoring devices.\n\nThe valid points are:',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Text(
                                          '    One point for a valid punch to the trunk protector\n    Two Points for a valid kick to the trunk protector\n    Four points for a valid turning kick to the trunk protector\n    Three points for a valid kick to the head\n    Five points for a valid turning kick to the head\n    One point awarded for every penalty (known as gam-jeom) given against the opponent',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Penalties and prohibited acts',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3949AB),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'The only penalty in taekwondo is a gam-jeom.\n\nA gam-jeom is declared when an athlete punches to the face, or punches or kicks below the waist.\n\nAlso not allowed is attacking an opponent with the knee or the head.\n\nAthletes are penalised if they use their leg to block or kick their opponent\'s leg to prevent a kicking attack, have their leg in the air for more than three seconds to impede an opponent’s potential attacking movements, or if a kick is adjudged to have been aiming for below the waist.\n\nTaekwondoin lose points for crossing the boundary line with both feet, falling to the ground, avoiding or delaying the match, and for pushing or grabbing their opponents\n\nFalling to the ground is penalised in taekwondo.\n\nContestants also have to watch out how they deliver their kicks to the trunk PSS, as one can lose a point for attacking with the side or bottom of the foot while the knee is pointed out in clinch position.\n\nAttacking a fallen opponent is also prohibited. Any misconduct or unsportsmanlike behaviour of the contestant or their coach can cost a point.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Taekwondo Equipment List',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                        AlignmentDirectional(0, -0.45),
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 20, 0, 0),
                                          child: Image.asset(
                                            'assets/taekwondo-equipment-list.png',
                                            width: double.infinity,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.2,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Text(
                                          'chest Protector',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF303F9F),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-chest-protector.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'one way to score point in taekwondo is to kick or punch your opponent in the torso, which is covered by a chest protector or hogu. The hogu is a vest that covers your entir torso so you will not be injured during competition or practice.\n\nwhen looking for a chest protector it should de very durable so it can protect you, and also be snug. you do not want it  to be moving around during competition or training. Some hogus are made with an electronic scoring system attached to the inside. this is how competition are scored.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Foot Protector ',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF303F9F),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-foot-protector.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'In taekwondo, kicking is a great way to score points on your opponent because of all the momentum that is drawn from the hips. However, all that force makes your feet susceptible to injury, so foot protectors are worn to help prevent these injuries during competition and training.',
                                          style:TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Forearm Guards',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF303F9F),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-forearm-guards.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'Defending yourself is a crucial part of any combat sport. In taekwondo, you often use your forearms to guard kicks and punches. Forearm guards are used to reduce the impact that those strikes make.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Groin Guard',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF303F9F),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-groin-guard.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'Accidents happen, and sometimes in taekwondo an opponent will kick you in the groin. To relieve some of the pain this causes, it is advised to wear a groin guard during competition and training',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Gloves',
                                          style:TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3949AB),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-hand-guards.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'In taekwondo, punches can be delivered to your opponent\'s body and head to score points. In order to protect yourself and your opponent, you should invest in some gloves.',
                                          style:TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Hand Wraps',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3949AB),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-hand-wraps.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'Training can take a toll on your hands and wrists, which is why many fighters use hand wraps to prevent injuries. Hand wraps are usually made out of cloth and are used to wrap a fighter\'s wrist and hands. This prevents the skin from being cut and prevents the wrist from bending in awkward positions when punching',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Headgear',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3949AB),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-headgear.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'Protecting your brain may be the most important precaution you can take as a fighter. Although some competitions do not require headgear to be worn by fighters, it is a necessity to prevent injury in training.\n\nFor competitions, you should get headgear that is approved by the World Taekwondo Federation. Headgear has padding that covers the entire head and even the ears, all while having holes to provide ventilation. They are made of spongy material that serves as a great shock absorber and are covered in urethane. Another feature that these pieces of headgear have is an elastic strap to secure it tight. In competitions, you will wear either a blue or red headgear, so having one of each color is not a bad idea',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Mouthguard',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3949AB),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-mouthguard.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'If you are in any contact sport, a mouthguard is a must have. It protects you from losing teeth and biting your tongue. There are different types of mouthguards.\n\nThe boil and bite mouth guard is the most common type. This type of mouthguard is made with a material that softens when it is put under boiling water, so when you take it out, you can bite down on the guard and mold it to your teeth. It will eventually harden so it can slip right on and off.\n\nThe other kind is the custom mouthguard. These are much more expensive and can sometimes require you to see a dental professional to get them made. This style offers the most protection because it is the most customizable',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Shin Guards',
                                          style:TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-shin-guards.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'Continuous kicking can cause your shins to bruise up and even fracture, so it is important to invest in some shin guards to prevent injury.\n\nIn order to wear shin guards during competition, they need to be approved by the World Taekwondo Federation.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Shoes',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF3949AB),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: Image.asset(
                                          'assets/taekwondo-shoes.png',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'It is extremely common to see taekwondo being practiced barefoot, but some instructors or schools may require you to wear shoes.\n\nWhen looking for shoes, they should have a non-slip rubber sole. This will prevent you from slipping during training.\n\nThe upper material is also important to pay attention to because a rigid one can cause discomfort. Upper materials are usually made out of soft leather, canvas, or synthetic materials. Soft leather shoes are more durable, while canvas shoes are very breathable',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.vertical,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Benefits of Martial Arts / Taekwondo',
                                        style:TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: Text(
                                          'We train our students to the best of THEIR ability.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Some students come to us in shape, while others have come to us 100 pounds overweight. Most come to us with limited flexibility. Adults start at any age, as we have had some adults who started as late as age 65 and have still earned their black belts. As a student, you are looked upon as an individual, never compared to anyone else. ',
                                        style:TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Our instructors will be there every step of the way. All that is expected is a willingness to try.',
                                        style:TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Fitness',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'The principles of Taekwondo techniques are based on the design of your body. For power you develop the larger, powerful muscles of the torso. The speed of the techniques comes from the fast, agile muscles of the arms and legs. As you progress in Taekwondo, you will learn to coordinate this speed and power, and develop the concentration to focus all of your body\'s strength into a small, hard striking surface like the edge of the hand or the heel of a foot.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Self-Defense',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'When the speed and power developed through Taekwondo is used in a self-defense situation against the vulnerable parts of an attacker\'s body, the results can be incredible. Taekwondo allows a woman to emphasize many of her natural physical strengths, such as power in the legs, while learning a method of self-defense efficient against a much larger opponent.',
                                          style:TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Self-Confidence',
                                          style:TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'This does not come naturally for many people, but self-confidence can be developed over a period of time. Through Taekwondo as you accomplish new goals, your confidence level increases. Taekwondo instills a sense of discipline and self-confidence that can carry over to all aspects of your life.',
                                          style:TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: Text(
                                          'Here are some additional benefits of Taekwondo:',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 7, 0, 0),
                                        child: Text(
                                          'Self Discipline, Self Control, Goal Setting, Family Time, Stress Relief, After School Transportation, and make New Friends.',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, 1),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                            child: SmoothPageIndicator(
                              controller: pageViewController ??=
                                  PageController(initialPage: 0),
                              count: 4,
                              axisDirection: Axis.horizontal,
                              onDotClicked: (i) {
                                pageViewController.animateToPage(
                                  i,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              },
                              effect: ExpandingDotsEffect(
                                expansionFactor: 2,
                                spacing: 8,
                                radius: 16,
                                dotWidth: 10,
                                dotHeight: 10,
                                dotColor: Color(0xFF9E9E9E),
                                activeDotColor: Color(0xFFD41313),
                                paintStyle: PaintingStyle.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
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
