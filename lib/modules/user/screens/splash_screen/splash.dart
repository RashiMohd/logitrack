import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 
import 'package:google_fonts/google_fonts.dart';
import 'package:logitrack/modules/user/screens/boarding_screen/first_bording.dart';

import 'package:logitrack/utils/colors.dart';
import 'package:logitrack/utils/responsivesize.dart';

class SplashScreenUser extends StatefulWidget {
  const SplashScreenUser({super.key});

  @override
  State<SplashScreenUser> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenUser> {


  
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4)).then((value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BoardingScreen(),
        )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsClass.SplashScreenbg,
      body: Center(
        child: Text(
          'LogiTrack',
          style: GoogleFonts.heebo(
            fontWeight: FontWeight.bold,
            color: ColorsClass.whiteColor,
            fontSize: Helper.W(context) * .150,
          ),
        ),
      ),
    );
  }
}
