import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intertwined/src/model/text_snippets.dart';

class DatabaseService {
  final FirebaseFirestore _firestore;
  DatabaseService(this._firestore);

  Future<String> createTextSnippet(User user, TextSnippet snippet) async {
    assert(user != null);
    try {
      String collectionPath = 'users/${user.uid}/textSnippets';
      CollectionReference snippetsCollection =
          _firestore.collection(collectionPath);
      final reference = await snippetsCollection.add(snippet.toMap());
      if (reference?.id == null) {
        throw Exception('Something went wrong');
      }
      return reference.id;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<TextSnippet>> readTextSnippets(User user) async {
    assert(user != null);
    try {
      String collectionPath = 'users/${user.uid}/textSnippets';
      CollectionReference snippetsCollection =
          _firestore.collection(collectionPath);
      QuerySnapshot result = await snippetsCollection.get();
      return result.docs.map((doc) => TextSnippet.fromDocumentSnapshot(doc));
    } catch (e) {
      return Future.error(e);
    }
  }

  Stream<List<TextSnippet>> watchTextSnippets(User user) {
    assert(user != null);

    String collectionPath = 'users/${user.uid}/textSnippets';
    CollectionReference snippetsCollection =
        _firestore.collection(collectionPath);
    return snippetsCollection
        .orderBy('last-updated', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map<TextSnippet>((doc) => TextSnippet.fromDocumentSnapshot(doc))
              .toList(),
        );
  }

  Future<void> updateTextSnippet(User user, TextSnippet snippet) {
    assert(user != null);
    assert(snippet?.id == null);

    String collectionPath = 'users/${user.uid}/textSnippets';
    CollectionReference snippetsCollection =
        _firestore.collection(collectionPath);
    DocumentReference doc = snippetsCollection.doc(snippet.id);
    return doc.update(snippet.toMap());
  }

  Future<void> deleteTextSnippet(User user, TextSnippet snippet) async {
    String collectionPath = 'users/${user.uid}/textSnippets';
    CollectionReference snippetsCollection =
        _firestore.collection(collectionPath);
    DocumentReference doc = snippetsCollection.doc(snippet.id);
    return doc.delete();
  }
}
