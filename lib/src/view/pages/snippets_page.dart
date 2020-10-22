import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intertwined/src/db/auth.dart';
import 'package:intertwined/src/db/database.dart';
import 'package:intertwined/src/model/text_snippets.dart';
import 'package:intertwined/src/view/widgets/snippet_card.dart';
import 'package:provider/provider.dart';

class SnippetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<List<TextSnippet>>(
        stream: DatabaseService(FirebaseFirestore.instance)
            .watchTextSnippets(authService.currentUser),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            throw UnimplementedError();
          }
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return SnippetCard(snapshot.data[i]);
              });
        });
  }
}

