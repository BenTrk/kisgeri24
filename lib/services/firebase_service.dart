import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSingletonProvider {
  static final FirebaseSingletonProvider _instance =
      FirebaseSingletonProvider._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseSingletonProvider._internal();

  factory FirebaseSingletonProvider() {
    return _instance;
  }

  FirebaseAuth get authInstance => _auth;

  FirebaseFirestore get firestoreInstance => _firestore;

  static FirebaseSingletonProvider get instance => _instance;
}
