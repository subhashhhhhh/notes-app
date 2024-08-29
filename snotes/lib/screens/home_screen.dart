import 'package:flutter/material.dart';
import '../models/note.dart';

class HomeScreen extends StatelessWidget {
  final List<Note> notes = [
    // Example notes. You can replace this with dynamic data
    Note(
      id: '1',
      title: 'First Note',
      content: 'This is the content of the first note.',
      createdTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to NotesScreen
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Menu'),
          ),
          ListTile(
            title: Text('Deleted Notes'),
            onTap: () {
              // Navigate to Deleted Notes screen
            },
          ),
          ListTile(
            title: Text('Archived Notes'),
            onTap: () {
              // Navigate to Archived Notes screen
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Navigate to Settings screen
            },
          ),
        ],
      ),
    );
  }
}
