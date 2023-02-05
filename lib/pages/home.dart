import 'package:flutter/material.dart';
import 'package:notesapp/services/appstate.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppState? state;

  @override
  Widget build(BuildContext context) {
    state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notas App'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'nota');
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
            future: state!.getNotes(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List notes = snapshot.data ?? [];
              return ListView(
                children: [
                  for (Note note in notes)
                    ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.content),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline_outlined),
                        onPressed: () {
                          state!.deleteNote(note.key);
                        },
                      ),
                    )
                ],
              );
            }));
  }
}
