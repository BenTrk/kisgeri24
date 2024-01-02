import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseSingletonProvider {
  static final FirebaseSingletonProvider _instance =
      FirebaseSingletonProvider._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  FirebaseSingletonProvider._internal();

  factory FirebaseSingletonProvider() {
    return _instance;
  }

  FirebaseAuth get authInstance => _auth;

  FirebaseFirestore get firestoreInstance => _firestore;

  FirebaseDatabase get database => _database;

  static FirebaseSingletonProvider get instance => _instance;

  @override
  String toString() {
    return 'FirebaseSingletonProvider{_auth: $_auth, _firestore: $_firestore, _database: $_database}';
  }
}
