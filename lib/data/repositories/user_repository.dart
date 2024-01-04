import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/data/models/user.dart';
import 'package:kisgeri24/data/repositories/crud_repository.dart';

class UserRepository extends CrudRepository<User> {
  final FirebaseFirestore firestore;

  UserRepository(this.firestore);

  @override
  Future<void> delete(String id) {
    throw UnsupportedError("Deleting user is not supported by client.");
  }

  @override
  Future<List<User>> fetchAll() {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> fetchAllByYear(String year) {
    throw UnimplementedError();
  }

  @override
  Future<void> save(User entity) {
    throw UnsupportedError("Creating user is not supported by client.");
  }

  @override
  Future<void> update(User entity) async {
    await firestore
        .collection(usersCollection)
        .doc(entity.userID)
        .set(entity.toJson());
  }

  @override
  Future<User?> getById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(usersCollection).doc(id).get();
    if (userDocument.data() != null && userDocument.exists) {
      User user = User.fromJson(userDocument.data()!);
      return user;
    } else {
      return null;
    }
  }
}
