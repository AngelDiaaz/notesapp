import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/services/services.dart';

import '../models/note.dart';

class NewNote extends StatefulWidget {
  final Note note;

  const NewNote({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
  final TextEditingController titleController = TextEditingController(text: widget.note.title);
  final TextEditingController contentController = TextEditingController(text: widget.note.content);
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.white70,
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration:
                          const InputDecoration(labelText: 'Título de la nota'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: contentController,
                      decoration: const InputDecoration(labelText: 'Contenido'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido';
                        }
                        return null;
                      },
                      maxLines: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              final messenger = ScaffoldMessenger.of(context);
                              if (_formKey.currentState!.validate()) {
                                bool response = await Provider.of<AppState>(
                                        context,
                                        listen: false)
                                    .saveNotes(titleController.text,
                                        contentController.text);

                                if (response) {
                                  navigator.pop();
                                  messenger.showSnackBar(const SnackBar(
                                    content: Text('Nota guardada'),
                                    backgroundColor: Colors.green,
                                  ));
                                } else {
                                  messenger.showSnackBar(const SnackBar(
                                    content: Text('Error al guardar la nota'),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }
                            },
                            child: const Text('Aceptar')),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async => Navigator.pop(context),
                            child: const Text('Cancelar')),
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }

  // @override
  // void dispose() {
  //   titleController.dispose();
  //   contentController.dispose();
  //   super.dispose();
  // }
}
