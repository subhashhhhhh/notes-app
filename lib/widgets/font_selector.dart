import 'package:flutter/material.dart';

class FontSelector extends StatelessWidget {
  final String selectedFont;
  final ValueChanged<String> onFontSelected;

  FontSelector({required this.selectedFont, required this.onFontSelected});

  final List<String> fonts = [
    'Poppins',
    'Roboto',
    'Lobster',
    // Add more fonts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: fonts.map((font) {
        return ChoiceChip(
          label: Text(font, style: TextStyle(fontFamily: font)),
          selected: selectedFont == font,
          onSelected: (selected) {
            onFontSelected(font);
          },
        );
      }).toList(),
    );
  }
}