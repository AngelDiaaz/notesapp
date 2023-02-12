import 'package:flutter/material.dart';
import 'package:notesapp/services/appstate.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import 'new_notes.dart';

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
        floatingActionButton: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, 'nota');
            },
            child: const Icon(
              Icons.add,
              size: 42,
            ),
          ),
        ),
        body: FutureBuilder(
            future: state!.getNotes(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List notes = snapshot.data ?? [];
              return ListView(
                children: [
                  for (Note note in notes)
                    TextButton(
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
                        subtitle: Text(note.content,
                            maxLines: 5, style: const TextStyle(fontSize: 14)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline_outlined),
                          color: Colors.redAccent,
                          onPressed: () {
                            state!.deleteNote(note.key);
                          },
                        ),
                      ),
                    ),
                ],
              );
            }));
  }
}
