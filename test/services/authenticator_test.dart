@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<DocumentReference<Map<String, dynamic>>>(),
  MockSpec<CollectionReference<Map<String, dynamic>>>(),
  MockSpec<DocumentSnapshot<Map<String, dynamic>>>()
])
import 'package:cloud_firestore/cloud_firestore.dart';
@GenerateNiceMocks([MockSpec<FirebaseAuth>(), MockSpec<User>()])
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kisgeri24/data/models/user.dart' as kisgeri;
import 'package:kisgeri24/services/authenticator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import "package:test/test.dart";

import 'authenticator_test.mocks.dart';
import 'test_utils.dart';

const String usersCollectionName = 'users';
const int once = 1;

late MockFirebaseAuth mockFirebaseAuth;
late MockFirebaseFirestore mockFirebaseFirestore;
late MockUser mockUser;
late Auth underTest;

void main() {
  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockUser = MockUser();
    underTest = Auth(mockFirebaseAuth, mockFirebaseFirestore);
  });

  testLogout();
  testGetAuthUser(); // todo: [MAJOR problem] is that if we'd move the execution of this method/test below the ResetPassword test then some of it will fail with a mocking issue therefore the test cases are not independent
  testResetPassword();
  testMessageResolution();
}

void testLogout() {
  test('Test when logout calls Firebase signOut()', () {
    when(mockFirebaseAuth.signOut()).thenAnswer((_) => Future.value());

    underTest.logout();

    verify(mockFirebaseAuth.signOut()).called(once);
    verifyNoMoreInteractions(mockFirebaseAuth);
  });
}

void testMessageResolution() {
  group("Test resolveExceptionCode() when exception happens", () {
    Map<String, String> inputs = {
      "invalid-email": "Email address is malformed.",
      "wrong-password": "Invalid email address or password.",
      "user-not-found": "Invalid email address or password.",
      "user-disabled": "This user has been disabled.",
      "too-many-requests": "Too many attempts to sign in as this user.",
      "something unmapped": "Unexpected firebase error, Please try again.",
    };
    inputs.forEach((input, expected) {
      test("Resolved message for $input is not the expected: $expected", () {
        expect(underTest.resolveExceptionCode(input), expected);
      });
    });
  });
}

void testResetPassword() {
  test("Test reset password", () {
    String email = "some@email.com";
    when(mockFirebaseAuth.sendPasswordResetEmail(email: email));

    underTest.resetPassword(email);

    verify(mockFirebaseAuth.sendPasswordResetEmail(email: email)).called(once);
    verifyNoMoreInteractions(mockFirebaseAuth);
  });
}

void testGetAuthUser() {
  group("Testing getAuthUser() method", () {
    String userId = "someUserID";
    test(
        "Test getAuthUser() when Firebase's current user is empty, then null should return.",
        () {
      underTest.getAuthUser().then((user) => {expect(user == null, true)});

      verifyZeroInteractions(mockFirebaseFirestore);
    });
    test(
        "Test getAuthUser() when Firebase's current user is not empty but the returned document does not exist",
        () {
      MockDocumentReference mockDocRef = MockDocumentReference();
      MockDocumentSnapshot mockDocSnapshot = MockDocumentSnapshot();
      MockCollectionReference mockCollRef = MockCollectionReference();

      mockUserDataFetch(mockDocRef, mockDocSnapshot, mockCollRef, userId);

      when(mockUser.uid).thenReturn(userId);
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

      underTest.getAuthUser().then((user) => {expect(user == null, true)});

      verify(mockFirebaseFirestore.collection(usersCollectionName))
          .called(once);
      verifyNoMoreInteractions(mockFirebaseFirestore);
      verify(mockCollRef.doc(userId)).called(once);
      verifyNoMoreInteractions(mockCollRef);
      verify(mockDocRef.get()).called(once);
      verifyNoMoreInteractions(mockDocRef);
    });
    test(
        "Test getAuthUser() when Firebase's current user is not empty and firebase document exists",
        () {
      MockDocumentReference mockDocRef = MockDocumentReference();
      MockDocumentSnapshot mockDocSnapshot = MockDocumentSnapshot();
      MockCollectionReference mockCollRef = MockCollectionReference();

      mockUserDataFetch(mockDocRef, mockDocSnapshot, mockCollRef, userId);

      when(mockDocSnapshot.exists).thenReturn(true);

      when(mockUser.uid).thenReturn(userId);
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

      Future<kisgeri.User?> result = underTest.getAuthUser();

      result.then((user) =>
          {expect(user == null, false), expect(user?.equals(testUser), true)});

      verify(mockFirebaseFirestore.collection(usersCollectionName))
          .called(once);
      verifyNoMoreInteractions(mockFirebaseFirestore);
      verify(mockCollRef.doc(userId)).called(once);
      verifyNoMoreInteractions(mockCollRef);
      verify(mockDocRef.get()).called(once);
      verifyNoMoreInteractions(mockDocRef);
    });
  });
}

void mockUserDataFetch(
    MockDocumentReference mockDocRef,
    MockDocumentSnapshot mockDocSnapshot,
    MockCollectionReference mockCollRef,
    String userId) {
  when(mockFirebaseFirestore.collection(usersCollectionName))
      .thenReturn(mockCollRef);
  when(mockCollRef.doc(userId)).thenReturn(mockDocRef);
  when(mockDocRef.get()).thenAnswer((_) async => Future.value(mockDocSnapshot));
  when(mockDocSnapshot.data()).thenReturn(testUser.toJson());
}
