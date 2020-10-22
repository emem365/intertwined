import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intertwined/src/constants/app_theme.dart';
import 'package:intertwined/src/model/text_snippets.dart';

class SnippetCard extends StatelessWidget {
  final TextSnippet snippet;
  SnippetCard(this.snippet);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          color: TileColors.fromCode(snippet.colorCode),
          child: ListTile(
            title: (snippet.title == '' || snippet.title == null)
                ? Text(
                    snippet.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : Text(snippet.title),
            subtitle: (snippet.title == '' || snippet.title == null)
                ? null
                : Text(
                    snippet.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            trailing: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: snippet.content));
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Content copied to Clipboard',
                        textAlign: TextAlign.center,
                      ),
                      behavior: SnackBarBehavior.floating,
                      width: MediaQuery.of(context).size.width / 1.5,
                    ),
                  );
                }),
          )),
    );
  }
}
