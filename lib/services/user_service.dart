import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:kisgeri24/data/models/user.dart' as kisgeri;
import 'package:kisgeri24/data/repositories/user_repository.dart';
import 'package:kisgeri24/logging.dart';

class UserService {
  final UserRepository repository;

  final FirebaseAuth firebaseAuth;

  UserService(this.repository, this.firebaseAuth);

  Future<kisgeri.User?> getCurrentUser() async {
    firebase.User? currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      kisgeri.User? user = await repository.getById(currentUser.uid);
      logger.d("Current authenticated user is: $user");
      return user;
    } else {
      logger.d("No logged in user found.");
      return null;
    }
  }

  Future<void> updateUser(kisgeri.User user) async {
    repository.getById(user.userID).then((value) {
      if (value != null) {
        logger.i(
            'Updating User from: ${value.toString()}, to: ${user.toString()}');
        repository.update(user);
      } else {
        logger.w(
            'User with ID [${user.userID}] cannot be found, therefore cannot be updated!');
      }
    });
  }

  int getRemainingTime(int compEnd) {
    return compEnd - DateTime.now().millisecondsSinceEpoch;
  }
}
