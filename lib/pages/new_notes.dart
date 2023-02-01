import 'package:flutter/material.dart';
import 'package:notesapp/pages/pages.dart';

class NewNote extends StatefulWidget {
  const NewNote({
    Key? key,
  }) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _contenidoController = TextEditingController();
  final GlobalKey<FormState> _formularioKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          // height: 300,
          color: Colors.white70,
          child: Form(
              key: _formularioKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _tituloController,
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
                      controller: _contenidoController,
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
                              if (_formularioKey.currentState!.validate()) {
                                bool respuesta = await UserServices().saveNotes(
                                    _tituloController.text,
                                    _contenidoController.text);

                                if (respuesta) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Nota guardada'),
                                    backgroundColor: Colors.green,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
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

  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    super.dispose();
  }
}
