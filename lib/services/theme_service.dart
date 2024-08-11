import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static const String _keyThemeMode = 'themeMode';
  static const String _keyFont = 'font';
  static const String _defaultFont = 'Poppins';

  ThemeMode _themeMode;
  String _selectedFont;

  ThemeService._(this._themeMode, this._selectedFont);

  static Future<ThemeService> init() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_keyThemeMode);
    final themeMode = themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
    final selectedFont = prefs.getString(_keyFont) ?? _defaultFont;
    return ThemeService._(themeMode, selectedFont);
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get selectedFont => _selectedFont;

  void toggleDarkMode(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyThemeMode, isDark ? 'dark' : 'light');
  }

  void setFont(String font) async {
    _selectedFont = font;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyFont, font);
  }

  static ThemeService of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<NotesApp>()!.themeService;
  }
}