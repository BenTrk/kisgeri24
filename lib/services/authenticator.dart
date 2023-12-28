import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:kisgeri24/constants.dart';
import 'package:kisgeri24/logging.dart' as log;
import 'package:kisgeri24/data/models/user.dart' as kisgeri;
import 'package:kisgeri24/services/utils.dart';

class Auth {
  final invalidEmailPwMsg = "Invalid email address or password.";
  final firebase.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  Auth(this.firebaseAuth, this.firestore);

  /// login with email and password with firebase
  /// @param email user email
  /// @param password user password
  Future<dynamic> login(String email, String password) async {
    log.logger.d("Login requested for email: $email");
    try {
      log.logger.i("About to try to perform login for email: $email");
      firebase.UserCredential result = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      log.logger.d(
          "Login operation ended up with the following UserCredential result: $result");
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore
          .collection(usersCollection)
          .doc(result.user?.uid ?? '')
          .get();
      kisgeri.User? user;
      if (documentSnapshot.exists) {
        log.logger.i("User exists and login was successful.");
        user = kisgeri.User.fromJson(documentSnapshot.data() ?? {});
        log.logger.d("Logged in user: $user");
      }
      return user;
    } on firebase.FirebaseAuthException catch (exception, s) {
      log.logger.w("FirebaseAuthException happened during the login operation!",
          error: exception);
      log.logger.w('$exception$s');
      return resolveExceptionCode((exception).code);
    } catch (e, s) {
      log.logger
          .w("Unexpected error happened during the login operation!", error: e);
      log.logger.w('$e$s');
      return 'Login failed, Please try again.';
    }
  }

  String resolveExceptionCode(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Email address is malformed.';
      case 'wrong-password':
        return invalidEmailPwMsg;
      case 'user-not-found':
        return invalidEmailPwMsg;
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts to sign in as this user.';
    }
    return 'Unexpected firebase error, Please try again.';
  }

  logout() async {
    log.logger.i("About to perform logout for user.");
    await firebaseAuth.signOut();
  }

  Future<kisgeri.User?> getAuthUser() async {
    log.logger.d("Getting auth user.");
    firebase.User? firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      kisgeri.User? user = await _getCurrentUser(firebaseUser.uid);
      log.logger.d("Current authenticated user is: $user");
      return user;
    } else {
      log.logger.d("Current Firebase user cannot be found.");
      return null;
    }
  }

  resetPassword(String emailAddress) async {
    log.logger.i("Email reset is requested for Firebase Auth for email: "
        "$emailAddress");
    await firebaseAuth.sendPasswordResetEmail(email: emailAddress);
  }

  @Deprecated("Kept for some time, shall be removed soon!")
  signUpWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String teamName,
    required String firstClimberName,
    required String secondClimberName,
    required String category,
    String? tenantId,
  }) async {
    log.logger.w(
        "signUpWithEmailAndPassword() is deprecated and will be removed soon!");
    try {
      firebase.UserCredential result =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: emailAddress, password: password);
      kisgeri.User user = kisgeri.User(
          email: emailAddress,
          teamName: teamName,
          userID: result.user?.uid ?? '',
          firstClimberName: firstClimberName,
          secondClimberName: secondClimberName,
          category: category,
          tenantId: calculateTenantId(tenantId),
          isStartDateSet:
              const bool.fromEnvironment("REGISTER_WITH_START_DATE_SET"));
      log.logger
          .i("About to request user creation using the following data: $user");
      String? errorMessage = await _createNewUser(user);
      if (errorMessage == null) {
        log.logger.i("User (with email: $emailAddress) created!");
        return user;
      } else {
        log.logger.w("User cannot be created due to: $errorMessage");
        return 'Couldn\'t sign up for firebase, Please try again.';
      }
    } on firebase.FirebaseAuthException catch (error) {
      log.logger.w("User registration failed!",
          error: error, stackTrace: error.stackTrace);
      log.logger.d('$error${error.stackTrace}');
      String message = 'Couldn\'t sign up';
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Email already in use, Please pick another email!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'Password must be more than 5 characters';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
      }
      return message;
    } catch (e, s) {
      log.logger.d('FireStoreUtils.signUpWithEmailAndPassword $e $s');
      return 'Couldn\'t sign up';
    }
  }

  @Deprecated("Shall be removed along with the signUpWithEmailAndPassword()")

  /// save a new user document in the USERS table in firebase firestore
  /// returns an error message on failure or null on success
  Future<String?> _createNewUser(kisgeri.User user) async => await firestore
      .collection(usersCollection)
      .doc(user.userID)
      .set(user.toJson())
      .then((value) => null, onError: (e) => e);

  @Deprecated("Also, once registration won't be feature, this can go as well")
  String? calculateTenantId(String? tenantId) {
    log.logger.d("Calculating tenant ID (with the input of: $tenantId)");
    String? result = tenantId;
    if (isNullOrEmpty(result)) {
      log.logger.d(
          "Input tenant ID value was null, about to check if it is given at environment variable level using the TENANT_ID variable key.");
      result = const String.fromEnvironment("TENANT_ID");
    }
    log.logger.d("Calculated tenant ID: $result");
    return result;
  }

  Future<kisgeri.User?> _getCurrentUser(String uid) async {
    log.logger.d("Getting current user by its id: $uid");
    DocumentSnapshot<Map<String, dynamic>> userDocument =
        await firestore.collection(usersCollection).doc(uid).get();
    if (userDocument.data() != null && userDocument.exists) {
      kisgeri.User user = kisgeri.User.fromJson(userDocument.data()!);
      log.logger.i("User exists: $user");
      return user;
    } else {
      log.logger.i("User does not exists with id: $uid");
      return null;
    }
  }
}
