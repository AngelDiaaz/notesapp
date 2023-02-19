import 'package:flutter/material.dart';
import 'package:notesapp/services/appstate.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../values/theme.dart';
import 'new_notes.dart';

///Clase Home de la app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppState? state;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // Creo un state para llamar a los metodos de la base de datos
    state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notas',
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Cabin',
                  fontWeight: FontWeight.w600)),
          centerTitle: true,
          actions: [
            IconButton(
              // Al pulsar cambia el tema de claro a oscuro y viceversa
              onPressed: () {
                final themeProvider =
                    Provider.of<ThemeProvider>(context, listen: false);
                setState(() {
                  isDarkMode = !isDarkMode;
                });

                isDarkMode
                    ? themeProvider.setDarkMode()
                    : themeProvider.setLightMode();
              },
              icon: const Icon(Icons.dark_mode_outlined),
            ),
          ],
        ),
        floatingActionButton: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            // Al pulsar se me abre la vista para crear una nueva nota
            onPressed: () {
              Navigator.pushNamed(context, 'nota');
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
        body: FutureBuilder(
            future: state!.getNotes(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List notes = snapshot.data ?? [];
              // Listo todas las notas que tengo en la base de datos en la vista
              return ListView(
                children: [
                  for (Note note in notes) _noteCard(context, note),
                ],
              );
            }));
  }

  /// Widget de una nota
  Card _noteCard(BuildContext context, Note note) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 1,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: TextButton(
          // Al pulsar me dirige a una pestaña con la informacion mas detallada de la nota
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewNote(
                        note: note,
                      )),
            );
          },
          child: ListTile(
            title: Text(
              note.title,
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              note.content,
              maxLines: 5,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              alignment: Alignment.center,
              icon: const Icon(Icons.delete_outline_outlined, size: 26),
              // Al pulsar elimino la nota de la base de datos
              onPressed: () {
                state!.deleteNote(note.key);
              },
            ),
          ),
        ));
  }
}
