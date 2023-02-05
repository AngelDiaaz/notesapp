import 'package:flutter/material.dart';

const Color primary = Color(0xffA39BA8);
const Color purple = Color(0xffC2B2B4);
const Color lightBlue = Color(0xffB8C5D6);
const Color darkGreen = Color(0xff272D2D);
const Color esmeralda = Color(0xff23CE6B);

ThemeData myTheme(BuildContext context){
  return ThemeData(
    primaryColor: primary,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.purple,
    ).copyWith(
      secondary: Colors.indigo,
    )
  );
}

