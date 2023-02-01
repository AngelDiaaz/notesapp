import 'package:notesapp/models/note.dart';

class UserServices {
  Future<List<Note>> getNotes() async {
    List<Note> myNotes = [
      Note(title: 'Titulo 1', content: 'Contenido nota 1'),
      Note(title: 'Titulo 2', content: 'Contenido nota 2'),
      Note(title: 'Titulo 3', content: 'Contenido nota 3'),
      Note(title: 'Titulo 4', content: 'Contenido nota 4'),
    ];
    return myNotes;
  }
}