import 'package:flutter/material.dart';

class FormattingToolbar extends StatelessWidget {
  final ValueChanged<String> onFormatSelected;

  FormattingToolbar({required this.onFormatSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.format_bold),
            onPressed: () => onFormatSelected('bold'),
          ),
          IconButton(
            icon: Icon(Icons.format_italic),
            onPressed: () => onFormatSelected('italic'),
          ),
          IconButton(
            icon: Icon(Icons.format_underline),
            onPressed: () => onFormatSelected('underline'),
          ),
          IconButton(
            icon: Icon(Icons.format_list_bulleted),
            onPressed: () => onFormatSelected('bullet'),
          ),
          IconButton(
            icon: Icon(Icons.format_list_numbered),
            onPressed: () => onFormatSelected('number'),
          ),
        ],
      ),
    );
  }
}