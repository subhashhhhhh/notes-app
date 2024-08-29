import 'package:flutter/material.dart';

class MarkdownToolbar extends StatelessWidget {
  final TextEditingController controller;

  MarkdownToolbar({required this.controller});

  void _insertText(String text) {
    final selection = controller.selection;
    final newText = controller.text.replaceRange(
      selection.start,
      selection.end,
      text,
    );
    controller.text = newText;
    controller.selection = selection.copyWith(
      baseOffset: selection.start + text.length,
      extentOffset: selection.start + text.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Icon(Icons.format_bold),
          onPressed: () => _insertText('**bold**'),
        ),
        IconButton(
          icon: Icon(Icons.format_italic),
          onPressed: () => _insertText('_italic_'),
        ),
        IconButton(
          icon: Icon(Icons.format_strikethrough),
          onPressed: () => _insertText('~~strikethrough~~'),
        ),
        IconButton(
          icon: Icon(Icons.code),
          onPressed: () => _insertText('`code`'),
        ),
        IconButton(
          icon: Icon(Icons.link),
          onPressed: () => _insertText('[link](url)'),
        ),
      ],
    );
  }
}
