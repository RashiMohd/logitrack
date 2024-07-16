import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 
import 'package:google_fonts/google_fonts.dart';
import 'package:logitrack/modules/user/screens/auth_service/Loggin_screen.dart';
import 'package:logitrack/utils/colors.dart';
import 'package:logitrack/utils/images.dart';
import 'package:logitrack/utils/responsivesize.dart';
import 'package:logitrack/widgets/container.dart';

class BoardingScreenSecond extends StatelessWidget {
  const BoardingScreenSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: Helper.H(context) * .300,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Images.onbordingsecond),
              ),
            ),
          ),
          SizedBox(
            height: Helper.H(context) * .040,
          ),
          Text(
            'Speeding to Your Doorstep',
            style: GoogleFonts.heebo(
              fontSize: Helper.W(context) * .080,
            ),
          ),
          SizedBox(
            height: Helper.H(context) * .150,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogginScreenUser()));
            },
            child: ContainerWidget(
              width: Helper.W(context) * .350,
              height: Helper.H(context) * .050,
              radius: Helper.W(context) * .050,
              text: 'Next',
            ),
          )
        ],
      ),
    );
  }
}
