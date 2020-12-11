import 'package:flutter/material.dart';
import 'package:intertwined/src/model/text_snippets.dart';
import 'package:intertwined/src/view/pages/edit_snippet.dart';

class AddSnippetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditSnippet(
                TextSnippet.newSnippet(),
              ),
            ),
          );
        },
        tooltip: 'Add Snippet',
        child: Icon(Icons.add),
      );
  }
}