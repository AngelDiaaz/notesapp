import 'package:notesapp/models/note.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

// Arreglar dependencias firebase
// Min 6:38

class UserServices {
  Future<List<Note>> getNotes() async {
    List<Note> myNotes = [];
    //TODO añadir luego un try catch
    await Firebase.initializeApp();
    DataSnapshot snap = await FirebaseDatabase.instance.reference().child('notes').once();

    if (snap.exists) {
      snap.value.forEach((key, value){
        Map mapa = {'key':key, ...value};
        Note newNote = Note(
          content: mapa['body'],
          key: mapa['key'],
          title: mapa['title'],
        );
        print(newNote);
      });
    }
    return myNotes;
  }

  Future<bool> saveNotes(String title, String content) async {
    try {
      await Firebase.initializeApp();
      await FirebaseDatabase.instance
          .reference()
          .child('notes')
          .push()
          .set({'title': title, 'body': content});
      return true;
    } catch (e) {
      return false;
    }
  }
}
