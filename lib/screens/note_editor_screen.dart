import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../widgets/markdown_toolbar.dart';
import '../services/note_service.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  NoteEditorScreen({this.note});

  @override
  _NoteEditorScreenState createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late NoteService _noteService;

  @override
  void initState() {
    super.initState();
    _noteService = NoteService();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Title'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                decoration: const InputDecoration(hintText: 'Start writing...'),
              ),
            ),
            MarkdownToolbar(controller: _contentController),
          ],
        ),
      ),
    );
  }

  void _saveNote() async {
    final id = widget.note?.id ?? const Uuid().v4();
    final newNote = Note(
      id: id,
      title: _titleController.text,
      content: _contentController.text,
      createdAt: widget.note?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _noteService.saveNote(newNote);
    Navigator.pop(context);
  }
}
