import 'package:flutter/material.dart';
import '../models/note.dart';
import '../widgets/note_item.dart';
import '../screens/note_editor_screen.dart';
import '../services/note_service.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteService _noteService = NoteService();
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    await _noteService.loadNotes();
    setState(() {
      _notes = _noteService.getNotes();
      _filteredNotes = _notes;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredNotes = _notes.where((note) {
        final searchTerm = query.toLowerCase();
        return note.title.toLowerCase().contains(searchTerm) ||
            note.content.toLowerCase().contains(searchTerm);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NotesSearchDelegate(_notes, _onSearchChanged),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _buildNotesGrid(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteEditorScreen()),
          ).then((_) => _loadNotes());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Deleted Notes'),
            onTap: () {
              // Implement navigation to Deleted Notes screen
            },
          ),
          ListTile(
            title: const Text('Archived Notes'),
            onTap: () {
              // Implement navigation to Archived Notes screen
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SettingsScreen(noteService: _noteService)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _filteredNotes.length,
      itemBuilder: (context, index) {
        return NoteItem(note: _filteredNotes[index]);
      },
    );
  }
}

class NotesSearchDelegate extends SearchDelegate {
  final List<Note> notes;
  final Function(String) onSearchChanged;

  NotesSearchDelegate(this.notes, this.onSearchChanged);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearchChanged(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = notes.where((note) {
      final searchTerm = query.toLowerCase();
      return note.title.toLowerCase().contains(searchTerm) ||
          note.content.toLowerCase().contains(searchTerm);
    }).toList();

    return _buildResults(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchChanged(query);
    return _buildResults(notes);
  }

  Widget _buildResults(List<Note> results) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return NoteItem(note: results[index]);
      },
    );
  }
}
