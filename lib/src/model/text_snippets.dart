import 'package:cloud_firestore/cloud_firestore.dart';

class TextSnippet {
  DateTime lastUpdated;
  String title;
  String content;

  TextSnippet({
    this.lastUpdated,
    this.title,
    this.content,
  });

  factory TextSnippet.fromMap(Map<String, dynamic> map) {
    return TextSnippet(
      lastUpdated: DateTime.parse(map['last-updated'].toDate().toString()),
      title: map['title'],
      content: map['content'],
    );
  }

  Map toMap() {
    return {
      'title': title,
      'content': content,
      'last-updated': Timestamp.fromDate(lastUpdated),
    };
  }
}
