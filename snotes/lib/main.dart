import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/note_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NoteService noteService = NoteService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Keep Clone',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          onPrimary: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
        cardColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.blue,
          onPrimary: Colors.black,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        cardColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      themeMode: ThemeMode.system, // Use system theme (light/dark)
      home: HomeScreen(),
    );
  }
}
