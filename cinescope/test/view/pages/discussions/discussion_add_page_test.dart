import 'package:cinescope/model/discussion.dart';
import 'package:cinescope/model/providers/discussion_provider.dart';
import 'package:cinescope/view/pages/discussions/discussion_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
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
    testWidgets("see if provider is called when submitting",
        (widgetTester) async {
      final mockDiscussionProvider = MockDiscussionProvider();
            await widgetTester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<DiscussionProvider>(create: ((context) => mockDiscussionProvider))
        ],
        child: const MaterialApp(
            home: Scaffold(
          body: DiscussionAddPage("tt1234"),
        )),
      ));
    });
  });
}
