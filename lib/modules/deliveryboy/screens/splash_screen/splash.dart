import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 
import 'package:google_fonts/google_fonts.dart';
 
import 'package:logitrack/utils/responsivesize.dart';

import '../../../../utils/colors.dart';

 
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
 
  //
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration(seconds: 2), () {
      try {
        //naviagte
      } catch (e) {
        print("Error navigating: $e");
      }
    });
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
