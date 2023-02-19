import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notesapp/models/models.dart';

class LoginServices {
  /// Metodo que obtiene y devuelve todos los usuarios de la base de datos
  Future<List<User>> getUsers() async {
    List<User> myUsers = [];
    try {
      await Firebase.initializeApp();
      DatabaseEvent snap =
          await FirebaseDatabase.instance.ref().child('users').once();

      if (snap.snapshot.exists) {
        for (var i = 0; i < snap.snapshot.children.length; i++) {
          var key = snap.snapshot.children.elementAt(i).key;
          dynamic value = snap.snapshot.children.elementAt(i).value;
          Map map = {'key': key, ...value};

          // Mapeo la informacion en un nuevo usuario
          User newUser = User(
            password: map['password'],
            key: map['key'],
            user: map['user'],
          );

          // Añado el usuario de la base de datos en una lista
          myUsers.add(newUser);
        }
      }
      return myUsers;
    } catch (e) {
      return myUsers;
    }
  }

  /// Metodo que inserta un usuario en la base de datos
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

  /// Metodo que elimina un usuario de la base de datos
  Future<bool> deleteUser(String key) async {
    try {
      await FirebaseDatabase.instance.ref().child('users').child(key).remove();
      return true;
    } catch (e) {
      return false;
    }
  }
}
