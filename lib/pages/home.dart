import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/user_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'nuevo'),
      ),
      body: FutureBuilder(
        future: UserServices().getNotes(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          List notes = snapshot.data ?? [];
          return ListView(
            children: [
              for(Note note in notes)
                ListTile(
                  title: Text(note.title!),
                  subtitle: Text(note.content!),
                )
            ],
          );
        })
    );
  }
}

