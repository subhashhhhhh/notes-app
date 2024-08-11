import 'package:flutter/material.dart';
import '../services/theme_service.dart';
import '../widgets/font_selector.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeService = ThemeService.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Font'),
            FontSelector(
              selectedFont: themeService.selectedFont,
              onFontSelected: (font) {
                themeService.setFont(font);
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode'),
                Switch(
                  value: themeService.isDarkMode,
                  onChanged: (value) {
                    themeService.toggleDarkMode(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}