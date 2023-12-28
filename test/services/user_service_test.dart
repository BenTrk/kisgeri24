@GenerateNiceMocks([MockSpec<UserRepository>()])
import 'package:kisgeri24/data/repositories/user_repository.dart';
import 'package:kisgeri24/services/user_service.dart';
import 'package:kisgeri24/data/models/user.dart' as kisgeri;
@GenerateNiceMocks(
    [MockSpec<firebase.FirebaseAuth>(), MockSpec<firebase.User>()])
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import "package:test/test.dart";

import 'user_service_test.mocks.dart';
import 'test_utils.dart';

late MockUserRepository mockUserRepository;
late MockFirebaseAuth mockFirebaseAuth;
late MockUser mockFirebaseUser;
late UserService underTest;

void main() {
  mockUserRepository = MockUserRepository();
  mockFirebaseAuth = MockFirebaseAuth();
  mockFirebaseUser = MockUser();
  underTest = UserService(mockUserRepository, mockFirebaseAuth);

  testGetCurrentUser();
}

void testGetCurrentUser() {
  test(
      "Test getCurrentUser when logged in user found by firebase Auth and user can be found in repository",
      () async {
    String authUid = "someUniqueIdForAuthenticatedUser";
    when(mockFirebaseUser.uid).thenReturn(authUid);
    when(mockFirebaseAuth.currentUser).thenReturn(mockFirebaseUser);
    when(mockUserRepository.getById(authUid))
        .thenAnswer((_) async => Future.value(testUser));

    kisgeri.User? result = await underTest.getCurrentUser();

    expect(result == null, false);
    expect(result!.equals(testUser), true);
  });
  test(
      "Test getCurrentUser when logged in user found by firebase Auth but user cannot be found in repository",
      () async {
    String authUid = "someUniqueIdForAuthenticatedUser";
    when(mockFirebaseUser.uid).thenReturn(authUid);
    when(mockFirebaseAuth.currentUser).thenReturn(mockFirebaseUser);
    when(mockUserRepository.getById(authUid))
        .thenAnswer((_) async => Future.value(null));

    kisgeri.User? result = await underTest.getCurrentUser();

    expect(result == null, true);
  });
  test("Test getCurrentUser when no logged in user found by firebase Auth",
      () async {
    when(mockFirebaseAuth.currentUser).thenReturn(null);

    kisgeri.User? result = await underTest.getCurrentUser();

    expect(result == null, true);
  });
}
