import 'package:cinescope/view/pages/main_page.dart';
import 'package:cinescope/view/pages/register_page.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("RegisterPage", () {
    testWidgets("Works correctly with valid input", (widgetTester) async {
      MockFirebaseAuth mockFirebaseAuth =
          MockFirebaseAuth(mockUser: MockUser(uid: "test-user"));

      FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore(
          authObject: mockFirebaseAuth.authForFakeFirestore);

      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: RegisterPage(
          firebaseAuth: mockFirebaseAuth,
          firebaseFirestore: fakeFirebaseFirestore,
        )),
      ));

      await widgetTester.enterText(
          find.byKey(const Key("emailField")), "grelha@sirze.pt");
      await widgetTester.enterText(find.byKey(const Key("passwordField")),
          "ninguempodesaberestapassword");
      await widgetTester.enterText(
          find.byKey(const Key("confirmPasswordField")),
          "ninguempodesaberestapassword");
      await widgetTester.tap(find.byKey(const Key("registerButton")));

      await widgetTester.pumpAndSettle();

      expect(find.byType(MainPage), findsOneWidget);

      expect(mockFirebaseAuth.currentUser, isNotNull);
    });
  });
}
