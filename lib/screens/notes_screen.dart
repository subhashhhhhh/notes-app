import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/formatting_toolbar.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notes = prefs.getStringList('notes') ?? [];
    });
  }

  Future<void> _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notes', _notes);
  }

  void _addOrEditNote([String? note]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteEditorScreen(note: note)),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        if (note != null) {
          final index = _notes.indexOf(note);
          if (index != -1) {
            _notes[index] = result;
          }
        } else {
          _notes.add(result);
        }
        _saveNotes();
      });
    }
  }

  void _deleteNote(String note) {
    setState(() {
      _notes.remove(note);
      _saveNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Notes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Dismissible(
                  key: Key(note),
                  onDismissed: (direction) {
                    _deleteNote(note);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Note deleted')),
                    );
                  },
                  child: ListTile(
                    title: Text(note),
                    onTap: () => _addOrEditNote(note),
                  ),
                );
              },
            ),
          ),
          FormattingToolbar(onFormatSelected: (format) {}),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditNote(),
        child: Icon(Icons.add),
      ),
    );
  }
}

class NoteEditorScreen extends StatefulWidget {
  final String? note;

  NoteEditorScreen({this.note});

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Navigator.pop(context, '');
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter your note here',
            border: OutlineInputBorder(),
          ),
          maxLines: null,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _controller.text);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}