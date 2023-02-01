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
      home: const MyHomePage(title: 'Notas App'),
      routes: {'nuevo': (context) => const NewNote()},
    );
  }
}

// Solucionar boton floating

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return const HomePage();
  }
}
