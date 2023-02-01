import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // height: 300,
      color: Colors.white70,
      child: Form(
          child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título de la nota'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Contenido'),
              maxLines: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Nota guardada')));
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
    );
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _contenidoController.dispose();
    super.dispose();
  }
}
