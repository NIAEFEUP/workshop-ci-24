import 'package:cinescope/model/discussion.dart';
import 'package:cinescope/model/providers/discussion_provider.dart';
import 'package:cinescope/view/pages/discussions/discussion_add_page.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'discussion_add_page_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<DiscussionProvider>(onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  final Discussion discussion = Discussion(
      "",
      "tt1234",
      "Discussion Title",
      "Discussion Description",
      "siuuuuu",
      DateTime(
        2022,
      ),
      [Comment("siuu", DateTime.now(), "siuuuuu")]);
  group('Discussion Add Page', () {
    testWidgets("see if provider is called when submitting with both fields filled",
        (widgetTester) async {
      final mockDiscussionProvider = MockDiscussionProvider();
      final firebaseAuth = MockFirebaseAuth(mockUser: MockUser(uid: "siuuuu"));
      await firebaseAuth.signInWithEmailAndPassword(email: "test@gmail.com", password: "kekw");
      await widgetTester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<DiscussionProvider>(
              create: ((context) => mockDiscussionProvider))
        ],
        child: MaterialApp(
            home: Scaffold(
          body: DiscussionAddPage("tt12345", authInstance: firebaseAuth,),
        )),
      ));

      await widgetTester.pumpAndSettle();

      await widgetTester.enterText(find.byKey(const Key("title-field")), "Test title");
      await widgetTester.enterText(find.byKey(const Key("body-field")), "Test body");
      await widgetTester.tap(find.byType(TextButton));

      verify(mockDiscussionProvider.addNewDiscussion(any)).called(1);

    });


  });
}
