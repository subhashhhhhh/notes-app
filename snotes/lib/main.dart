import 'package:flutter/material.dart';
import 'constants/theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
