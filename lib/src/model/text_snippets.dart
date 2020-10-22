import 'package:cloud_firestore/cloud_firestore.dart';

class TextSnippet {
  String id;
  DateTime lastUpdated;
  String title;
  String content;

  TextSnippet({
    this.id,
    this.lastUpdated,
    this.title,
    this.content,
  });

  factory TextSnippet.fromDocumentSnapshot(DocumentSnapshot doc) {
    final map = doc.data();
    return TextSnippet.fromMap(map)..id = doc.id;
  }
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
