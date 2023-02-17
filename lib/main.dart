import 'package:flutter/material.dart';
import 'package:notesapp/pages/pages.dart';
import 'package:notesapp/services/services.dart';
import 'package:notesapp/values/theme.dart';
import 'package:provider/provider.dart';

import 'models/note.dart';

void main() {
  runApp(
    MultiProvider(
      // create the provider
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Note note = Note(key: "", title: "", content: "");
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notas App',
        // theme: myTheme(context),
        theme: Provider.of<ThemeProvider>(context).currentTheme,
        routes: {
          '/': (_) => const HomePage(),
          'login': (_) => const Login(),
          'register': (_) => const Register(),
          'nota': (_) => NewNote(
                note: note,
              )
        },
        initialRoute: 'login',
      ),
    );
  }
}
