import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/note.dart';
import 'dart:convert';

class NoteService {
  List<Note> _notes = [];

  Future<void> loadNotes() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/notes.json');

    if (file.existsSync()) {
      final notesJson = json.decode(file.readAsStringSync()) as List;
      _notes = notesJson.map((json) => Note.fromJson(json)).toList();
    }
  }

  List<Note> getNotes() => _notes;

  Future<void> saveNote(Note note) async {
    if (_notes.any((existingNote) => existingNote.id == note.id)) {
      _notes = _notes.map((existingNote) {
        return existingNote.id == note.id ? note : existingNote;
      }).toList();
    } else {
      _notes.add(note);
    }
    await _saveToDisk();
  }

  Future<void> deleteNote(Note note) async {
    _notes.removeWhere((existingNote) => existingNote.id == note.id);
    await _saveToDisk();
  }

  Future<void> _saveToDisk() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/notes.json');
    final notesJson = json.encode(_notes.map((note) => note.toJson()).toList());
    file.writeAsStringSync(notesJson);
  }

  Future<void> backupNotes() async {
    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/notes_backup.json');
    final notesJson = json.encode(_notes.map((note) => note.toJson()).toList());
    file.writeAsStringSync(notesJson);
  }

  Future<void> restoreNotes() async {
    final directory = await getExternalStorageDirectory();
    final file = File('${directory!.path}/notes_backup.json');

    if (file.existsSync()) {
      final notesJson = json.decode(file.readAsStringSync()) as List;
      _notes = notesJson.map((json) => Note.fromJson(json)).toList();
      await _saveToDisk();
    }
  }
}
