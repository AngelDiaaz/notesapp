import 'package:notesapp/models/note.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notesapp/models/user.dart';

class LoginServices {
  Future<List<User>> getUsers() async {
    List<User> myUsers = [
      User(user: 'admin', password: 'admin')
    ];
    try {
      await Firebase.initializeApp();
      DatabaseEvent snap =
      await FirebaseDatabase.instance.ref().child('users').once();

      if (snap.snapshot.exists) {
        dynamic value;
        // print(snap.snapshot.value );
        for (var i = 0; i < snap.snapshot.children.length; i++) {
          var key = snap.snapshot.children
              .elementAt(i)
              .key;
          value = snap.snapshot.children
              .elementAt(i)
              .value;
          Map map = {'key': key, ...value};

          User newUser = User(
            password: map['password'],
            key: map['key'],
            user: map['user'],
          );
          myUsers.add(newUser);
        }
      }
      return myUsers;
    } catch (e) {
      return myUsers;
    }
  }

  Future<bool> saveUser(String user, String password) async {
    try {
      await Firebase.initializeApp();
      await FirebaseDatabase.instance
          .ref()
          .child('users')
          .push()
          .set({'user': user, 'password': password});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser(String key) async {
    try {
      await FirebaseDatabase.instance.ref().child('users')
          .child(key)
          .remove();
      return true;
    } catch (e) {
      return false;
    }
  }
}
