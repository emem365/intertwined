import 'package:flutter/material.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/db/database.dart';
import 'package:intertwined/src/model/text_snippets.dart';
import 'package:intertwined/src/view/widgets/snippet_card.dart';
import 'package:provider/provider.dart';

class SnippetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final dbService = Provider.of<DatabaseService>(context, listen: false);
    return StreamBuilder<List<TextSnippet>>(
        stream: dbService.watchTextSnippets(authService.currentUser),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw UnimplementedError();
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, i) {
                return SnippetCard(snapshot.data![i]);
              });
        });
  }
}
