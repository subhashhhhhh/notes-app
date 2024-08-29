import 'package:flutter/material.dart';
import '../services/note_service.dart';

class SettingsScreen extends StatefulWidget {
  final NoteService noteService;

  SettingsScreen({required this.noteService});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedFont = 'Roboto';
  bool _swipeToDelete = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Backup Notes'),
            onTap: () async {
              await widget.noteService.backupNotes();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Backup complete')),
              );
            },
          ),
          ListTile(
            title: Text('Restore Notes'),
            onTap: () async {
              await widget.noteService.restoreNotes();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Restore complete')),
              );
            },
          ),
          ListTile(
            title: Text('Font Options'),
            subtitle: Text('Selected: $_selectedFont'),
            onTap: () async {
              final result = await showDialog<String>(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Text('Select Font'),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, 'Roboto'),
                      child: Text('Roboto'),
                    ),
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, 'Lato'),
                      child: Text('Lato'),
                    ),
                    SimpleDialogOption(
                      onPressed: () => Navigator.pop(context, 'Open Sans'),
                      child: Text('Open Sans'),
                    ),
                  ],
                ),
              );
              if (result != null) {
                setState(() {
                  _selectedFont = result;
                });
              }
            },
          ),
          SwitchListTile(
            title: Text('Swipe to Delete'),
            value: _swipeToDelete,
            onChanged: (bool value) {
              setState(() {
                _swipeToDelete = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
