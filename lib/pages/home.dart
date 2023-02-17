import 'package:flutter/material.dart';
import 'package:notesapp/services/appstate.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
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
          title: const Text('Notas'),
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
              size: 40,
            ),
          ),
        ),
        body: FutureBuilder(
            future: state!.getNotes(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List notes = snapshot.data ?? [];
              return ListView(
                children: [
                  for (Note note in notes) noteCard(context, note),
                ],
              );
            }));
  }

  Card noteCard(BuildContext context, Note note) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 1,
        shadowColor: Colors.black38,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: TextButton(
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
              // color: const Color.fromRGBO(255, 110, 110, 1),
              onPressed: () {
                state!.deleteNote(note.key);
              },
            ),
          ),
        ));
  }
}
