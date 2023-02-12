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
    final TextEditingController titleController =
        TextEditingController(text: widget.note.title);
    final TextEditingController contentController =
        TextEditingController(text: widget.note.content);
    return Scaffold(
        appBar: AppBar(title: const Text('Nota'), centerTitle: true),
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
                      decoration: const InputDecoration(
                          labelText: 'Título de la nota',
                          labelStyle: TextStyle(
                            fontSize: 28.0,
                          )),
                      style: const TextStyle(fontSize: 22),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: contentController,
                      decoration: const InputDecoration(
                          labelText: 'Contenido',
                          labelStyle: TextStyle(
                            fontSize: 28.0,
                          )),
                      style: const TextStyle(fontSize: 18),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Este campo es requerido';
                        }
                        return null;
                      },
                      maxLines: 20,
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              final messenger = ScaffoldMessenger.of(context);
                              if (_formKey.currentState!.validate()) {
                                bool response = false;
                                if (widget.note.title.isNotEmpty &&
                                    widget.note.content.isNotEmpty) {
                                  response = await Provider.of<AppState>(
                                          context,
                                          listen: false)
                                      .updateNote(Note(
                                          key: widget.note.key,
                                          title: titleController.text,
                                          content: contentController.text));
                                } else {
                                  response = await Provider.of<AppState>(
                                          context,
                                          listen: false)
                                      .saveNotes(titleController.text,
                                          contentController.text);
                                }

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
                            child: const Text(
                              'Aceptar',
                              style: TextStyle(fontSize: 20),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            onPressed: () async => Navigator.pop(context),
                            child: const Text('Cancelar', style: TextStyle(fontSize: 20),)),
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }
}
