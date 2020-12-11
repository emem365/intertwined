import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intertwined/src/constants/app_theme.dart';

class TextSnippet {
  String id;
  DateTime lastUpdated;
  String title;
  String content;
  String colorCode;

  TextSnippet(
      {this.id, this.lastUpdated, this.title, this.content, this.colorCode});

  factory TextSnippet.newSnippet(){
    var rng = Random();
    int index = rng.nextInt(TileColors.colorCodes.length);
    return TextSnippet(colorCode: TileColors.colorCodes[index]);
  }
  factory TextSnippet.fromDocumentSnapshot(DocumentSnapshot doc) {
    final map = doc.data();
    return TextSnippet.fromMap(map).setId(doc.id);
  }
  factory TextSnippet.fromMap(Map<String, dynamic> map) {
    return TextSnippet(
      lastUpdated: DateTime.parse(map['last-updated'].toDate().toString()),
      title: map['title'],
      content: map['content'],
      colorCode: map['color-code'],
    );
  }

  TextSnippet setId(String documentId) {
    id = documentId;
    return this;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'title': title ?? '',
      'content': content,
      'last-updated': Timestamp.fromDate(lastUpdated),
      'color-code': colorCode,
    };
    return map;
  }

  TextSnippet updateSnippet(String newTitle, String newContent) {
    if (!(title == newTitle && content == newContent)) {
      title = newTitle;
      content = newContent;
      lastUpdated = DateTime.now();
    }
    return this;
  }
}
