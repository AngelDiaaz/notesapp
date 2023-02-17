import 'package:flutter/material.dart';

const Color primary = Color(0xffFFFBFC);
const Color purple = Color(0xff7E5A9B);
const Color lightBlue = Color(0xff007991);
const Color darkBlue = Color(0xff0D1821);
const Color darkGrey = Color(0xff172121);

ThemeData myTheme(BuildContext context){
  return ThemeData(
    primaryColor: purple, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: purple),

  );
}

