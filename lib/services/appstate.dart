import 'package:flutter/cupertino.dart';
import 'package:notesapp/models/models.dart';
import 'package:notesapp/services/users_services.dart';
import 'package:notesapp/services/services.dart';

class AppState with ChangeNotifier {
  /// Metodo que crea una nota en la base de datos
  Future<bool> saveNotes(String text, String text2) async {
    try {
      bool response = await UserServices().saveNotes(text, text2);
      if (response) {
        notifyListeners();
      }
      return response;
    } catch (e) {
      return false;
    }
  }

  List<Note> _myNotes = [];

  /// Metodo que devuelve todas las notas de la base de datos
  Future<List<Note>> getNotes() async {
    try {
      _myNotes = await UserServices().getNotes();
      return _myNotes;
    } catch (e) {
      return _myNotes;
    }
  }

  /// Metodo que elimina una nota de la base de datos
  Future<bool> deleteNote(String key) async {
    try {
      bool response = await UserServices().deleteNote(key);
      if (response) {
        notifyListeners();
      }
      return response;
    } catch (e) {
      return false;
    }
  }

  /// Metodo que modifica una nota de la base de datos
  Future<bool> updateNote(Note note) async {
    try {
      bool response = await UserServices().updateNote(note);
      if (response) {
        notifyListeners();
      }
      return response;
    } catch (e) {
      return false;
    }
  }

  List<User> _myUsers = [];

  /// Metodo que devuelve todos los usuarios de la base de datos
  Future<List<User>> getUsers() async {
    try {
      _myUsers = await LoginServices().getUsers();
      return _myUsers;
    } catch (e) {
      return _myUsers;
    }
  }

  /// Metodo que guarda un usuario de la base de datos
  Future<bool> saveUser(String user, String password) async {
    try {
      bool response = await LoginServices().saveUser(user, password);
      if (response) {
        notifyListeners();
      }
      return response;
    } catch (e) {
      return false;
    }
  }

  /// Metodo que elimina un usuario de la base de datos
  Future<bool> deleteUser(String key) async {
    try {
      bool response = await LoginServices().deleteUser(key);
      if (response) {
        notifyListeners();
      }
      return response;
    } catch (e) {
      return false;
    }
  }
}
