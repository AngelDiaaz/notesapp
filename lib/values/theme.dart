import 'package:flutter/material.dart';

const Color primary = Color(0xffA39BA8);
const Color purple = Color(0xffC2B2B4);
const Color lightBlue = Color(0xffB8C5D6);
const Color darkGreen = Color(0xff272D2D);
const Color esmeralda = Color(0xff23CE6B);

ThemeData myTheme(BuildContext context){
  return ThemeData(
    primarySwatch: Colors.blueGrey,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black38),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blueAccent),
      ),
      labelStyle: TextStyle(
        color: Colors.blueGrey,
      ),
    ),
  );
}

