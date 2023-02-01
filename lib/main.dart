import 'package:flutter/material.dart';
import 'package:notesapp/pages/pages.dart';
import 'package:notesapp/values/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notas App',
      theme: myTheme(context),
      routes: {
        '/': (_) => const HomePage(),
        'nota': (_) => const NewNote()},
      initialRoute: '/',
    );
  }
}
