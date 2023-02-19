import 'package:flutter/material.dart';
import 'package:notesapp/pages/pages.dart';
import 'package:notesapp/services/services.dart';
import 'package:notesapp/values/theme.dart';
import 'package:provider/provider.dart';

import 'models/note.dart';

void main() {
  runApp(
    MultiProvider(
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
    // Creamos una nota vacia para poder ir a la pestaña de notas y crear una
    Note note = Note(key: "", title: "", content: "");
    return ChangeNotifierProvider(
      create: (BuildContext context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notas App',
        theme: Provider.of<ThemeProvider>(context).currentTheme,
        // Declaro las rutas que tiene la app
        routes: {
          '/': (_) => const HomePage(),
          'login': (_) => const Login(),
          'register': (_) => const Register(),
          'nota': (_) => NewNote(
                note: note,
              )
        },
        // Inicio la app por la ruta del login
        initialRoute: 'login',
      ),
    );
  }
}
