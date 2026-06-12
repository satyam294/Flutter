import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookmarkService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  String get uid => _auth.currentUser!.uid;

  Future<void> addBookmark({
    required String title,
    required String url,
  }) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .add({
      'title': title,
      'url': url,
      'createdAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getBookmarks() {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteBookmark(
    String bookmarkId,
  ) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('bookmarks')
        .doc(bookmarkId)
        .delete();
  }

  Future<void> updateBookmark({
  required String bookmarkId,
  required String title,
  required String url,
  }) async {
  await _firestore
      .collection('users')
      .doc(uid)
      .collection('bookmarks')
      .doc(bookmarkId)
      .update({
        'title': title,
        'url': url,
      });
  }
}