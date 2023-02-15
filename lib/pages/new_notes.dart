import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notesapp/services/services.dart';
import '../models/models.dart';

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
  AppState? state;

  @override
  Widget build(BuildContext context) {
    state = Provider.of<AppState>(context, listen: true);
    final TextEditingController titleController =
        TextEditingController(text: widget.note.title);
    final TextEditingController contentController =
        TextEditingController(text: widget.note.content);
    return Scaffold(
        appBar: buildAppBar(context),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.white70,
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
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
                      height: 24,
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
                      height: 30,
                    ),
                    actionsButtons(context, titleController, contentController),
                  ],
                ),
              )),
        ));
  }

  Row actionsButtons(BuildContext context, TextEditingController titleController, TextEditingController contentController) {
    return Row(
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
                                response = await state!.updateNote(Note(
                                    key: widget.note.key,
                                    title: titleController.text,
                                    content: contentController.text));
                              } else {
                                response = await state!.saveNotes(
                                    titleController.text,
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
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: const Text('Nota'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.delete_outline_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              if (widget.note.key.isNotEmpty) {
                state!.deleteNote(widget.note.key);
              }
              Navigator.pop(context);
            },
          )
        ],
      );
  }
}
