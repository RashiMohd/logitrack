import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../../utils/responsivesize.dart';
 

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

List<String> option = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'];

List<String> lanugaes = [
  'English(us),',
  'malayalam',
  'Hindi',
  'Arabic',
  'bengali',
  'Chinese',
  'German',
  'Spanish',
  'Tamil',
  'Kannada',
  'Urdu',
];

class _LanguageState extends State<Language> {
  String? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Helper.H(context) / 1,
              child: ListView.builder(
                itemCount: option.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(lanugaes[index]),
                    trailing: Radio<String>(
                      value: option[index],
                      groupValue: currentIndex,
                      onChanged: (value) {
                        setState(() {
                          currentIndex = value;
                          log(currentIndex.toString());
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
