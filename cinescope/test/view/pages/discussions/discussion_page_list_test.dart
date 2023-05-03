import 'dart:collection';

import 'package:cinescope/model/discussion.dart';
import 'package:cinescope/model/providers/discussion_provider.dart';
import 'package:cinescope/view/cards/discussion_card.dart';
import 'package:cinescope/view/pages/discussions/discussion_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'discussion_page_list_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<DiscussionProvider>(onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  final Discussion discussion = Discussion(
      "",
      "tt1234",
      "Discussion Title",
      "Discussion Description",
      const Profile(),
      DateTime(
        2022,
      ),
      [Comment("siuu", DateTime.now(), const Profile())]);

  final Discussion discussion2 = Discussion(
      "",
      "tt1234",
      "Discussion Title 2",
      "Discussion Description 2",
      const Profile(),
      DateTime(
        2022,
      ),
      [Comment("siuu", DateTime.now(), const Profile())]);

  final Discussion discussion3 = Discussion(
      "",
      "not pog film id",
      "Discussion Title 2",
      "Discussion Description 2",
      const Profile(),
      DateTime(
        2022,
      ),
      [Comment("siuu", DateTime.now(), const Profile())]);

  group('Discussion List Page', () {
    testWidgets("renders the correct ammount of cards", (widgetTester) async {
      final mockDiscussionProvider = MockDiscussionProvider();
      when(mockDiscussionProvider.getDiscussionsByFilmId(any))
          .thenAnswer((realInvocation) async {
        final set = {discussion, discussion2, discussion3};
        return UnmodifiableSetView(set);
      });
      await widgetTester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<DiscussionProvider>(create: ((context) => mockDiscussionProvider))
        ],
        child: MaterialApp(
            home: Scaffold(
          body: DiscussionListPage("siuuu"),
        )),
      ));
      
      await widgetTester.pumpAndSettle();
      expect(find.byKey(const Key("discussion-card")), findsNWidgets(3));

    });
  });
}
