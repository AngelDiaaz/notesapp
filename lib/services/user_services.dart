import 'package:notesapp/models/note.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class UserServices {
  Future<List<Note>> getNotes() async {
    List<Note> myNotes = [];
    //TODO añadir luego un try catch
    await Firebase.initializeApp();
    DatabaseEvent snap = await FirebaseDatabase.instance.ref().child('notes').once();

    if (snap.snapshot.exists) {
      dynamic value;
      // print(snap.snapshot.value );
      for(var i = 0; i < snap.snapshot.children.length; i++){
        var key = snap.snapshot.children.elementAt(i).key;
        value = snap.snapshot.children.elementAt(i).value;
        Map map = {'key': key, ...value};

        Note newNote = Note(
          content: map['body'],
          key: map['key'],
          title: map['title'],
        );
        myNotes.add(newNote);
    }}
    return myNotes;
  }

  Future<bool> saveNotes(String title, String content) async {
    try {
      await Firebase.initializeApp();
      await FirebaseDatabase.instance
          .ref()
          .child('notes')
          .push()
          .set({'title': title, 'body': content});
      return true;
    } catch (e) {
      return false;
    }
  }
}
