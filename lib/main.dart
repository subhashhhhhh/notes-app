import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.init();
  runApp(NotesApp(themeService: themeService));
}

class NotesApp extends StatelessWidget {
  final ThemeService themeService;

  NotesApp({required this.themeService});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeService,
      builder: (context, _) {
        return MaterialApp(
          title: 'Notes',
          theme: ThemeData(
            useMaterial3: true,
            brightness:
                themeService.isDarkMode ? Brightness.dark : Brightness.light,
            colorSchemeSeed: Colors.teal,
            textTheme: GoogleFonts.getTextTheme(
                themeService.selectedFont, Theme.of(context).textTheme),
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}
