import 'package:cinescope/view/pages/login_page.dart';
import 'package:cinescope/view/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_exceptions/mock_exceptions.dart';
import 'package:mockito/mockito.dart';

void main() {
  group("LoginPage", () {
    testWidgets(" submits correctly", (widgetTester) async {
      MockFirebaseAuth mockFirebaseAuth =
          MockFirebaseAuth(mockUser: MockUser(uid: "test-user"));

      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LoginPage(
          authInstance: mockFirebaseAuth,
        )),
      ));

      await widgetTester.enterText(
          find.byKey(const Key("emailField")), "grelha@sirze.pt");
      await widgetTester.enterText(find.byKey(const Key("passwordField")),
          "ninguempodesaberestapassword");
      await widgetTester.tap(find.byKey(const Key("loginButton")));

      await widgetTester.pumpAndSettle();

      expect(find.byType(MainPage), findsOneWidget);

      expect(mockFirebaseAuth.currentUser, isNotNull);
    });

    testWidgets(" wrong password should show error", (widgetTester) async {
      MockFirebaseAuth mockFirebaseAuth =
          MockFirebaseAuth(mockUser: MockUser(uid: "test-user"));
      whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: "wrong-password"));

      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LoginPage(
          authInstance: mockFirebaseAuth,
        )),
      ));

      await widgetTester.enterText(
          find.byKey(const Key("emailField")), "grelha@sirze.pt");
      await widgetTester.enterText(find.byKey(const Key("passwordField")),
          "ninguempodesaberestapassword");
      
      await widgetTester.tap(find.byKey(const Key("loginButton")));
      expect(widgetTester.takeException(), isInstanceOf<FirebaseAuthException>());

      await widgetTester.pumpAndSettle(const Duration(seconds: 5));
      expect(mockFirebaseAuth.currentUser, null);
      expect(find.byType(MainPage), findsNothing);

    });

    testWidgets(" invalid email should show error", (widgetTester) async {
      MockFirebaseAuth mockFirebaseAuth =
          MockFirebaseAuth(mockUser: MockUser(uid: "test-user"));
      whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: "invalid-email"));

      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LoginPage(
          authInstance: mockFirebaseAuth,
        )),
      ));

      await widgetTester.enterText(
          find.byKey(const Key("emailField")), "grelha@sirze.pt");
      await widgetTester.enterText(find.byKey(const Key("passwordField")),
          "ninguempodesaberestapassword");
      await widgetTester.tap(find.byKey(const Key("loginButton")));
      expect(widgetTester.takeException(), isInstanceOf<FirebaseAuthException>());

      await widgetTester.pumpAndSettle();
      expect(mockFirebaseAuth.currentUser, null);
      expect(find.byType(MainPage), findsNothing);

    });

    testWidgets(" user not existant should show error", (widgetTester) async {
      MockFirebaseAuth mockFirebaseAuth =
          MockFirebaseAuth(mockUser: MockUser(uid: "test-user"));
      whenCalling(Invocation.method(#signInWithEmailAndPassword, null))
          .on(mockFirebaseAuth)
          .thenThrow(FirebaseAuthException(code: "user-not-foundz"));

      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: LoginPage(
          authInstance: mockFirebaseAuth,
        )),
      ));

      await widgetTester.enterText(
          find.byKey(const Key("emailField")), "grelha@sirze.pt");
      await widgetTester.enterText(find.byKey(const Key("passwordField")),
          "ninguempodesaberestapassword");
      await widgetTester.tap(find.byKey(const Key("loginButton")));
      expect(widgetTester.takeException(), isInstanceOf<FirebaseAuthException>());

      await widgetTester.pumpAndSettle();
      expect(mockFirebaseAuth.currentUser, null);
      expect(find.byType(MainPage), findsNothing);

    });
  });
}
