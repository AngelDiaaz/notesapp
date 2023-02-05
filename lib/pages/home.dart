import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/user_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notas App'),
          actions: [
            IconButton(
                onPressed: () => setState(() {}),
                icon: const Icon(Icons.refresh))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'nota');
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
            future: UserServices().getNotes(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List notes = snapshot.data ?? [];
              return ListView(
                children: [
                  for (Note note in notes)
                    ListTile(
                      title: Text(note.title!),
                      subtitle: Text(note.content!),
                    )
                ],
              );
            }));
  }
}
