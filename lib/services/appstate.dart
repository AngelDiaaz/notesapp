import 'package:flutter/cupertino.dart';
import 'package:notesapp/services/services.dart';
import '../models/note.dart';

class AppState with ChangeNotifier {
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

  Future<List<Note>> getNotes() async {
    try {
      _myNotes = await UserServices().getNotes();
      return _myNotes;
    } catch (e) {
      return _myNotes;
    }
  }

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
}
