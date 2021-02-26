import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:io';
import 'dart:convert';

class Backend {
  const Backend(this.hostUrl);

  final String hostUrl;

  Stream<User> get currentUserStream => FirebaseAuth.instance.userChanges();

  Future<void> signUp() async {
    await FirebaseAuth.instance.signInAnonymously();
  }

  Stream<List<String>> get favoritedRockets {
    final userId = FirebaseAuth.instance.currentUser.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((DocumentSnapshot) {
      if (!DocumentSnapshot.exists) {
        return [];
      }
      return DocumentSnapshot.data()['favorited_rockets'];
    });
  }

  Future<List<Rocket>> getRockets() async {
    final url = '$hostUrl/rockets';
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw HttpException('$(response.statusCode): $(response.reasonPhrase)',uri: Uri.tryParse(url));
    }
    final body = response.body;
  }
}
