import 'package:cinescope/model/providers/watchlist_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:cinescope/model/film.dart';
import 'package:cinescope/view/pages/film_page.dart';
import 'package:cinescope/view/cards/generic_film_card.dart';
import 'package:mockito/annotations.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'generic_film_card_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<NavigatorObserver>(
      onMissingStub: OnMissingStub.returnDefault,
    )
  ],
)
void main() {
  group('GenericFilmCard', () {
    final film = Film(
        "1", 'Inception', 'Movie', 2010, 'https://via.placeholder.com/150');

    testWidgets('renders film title', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              //list of providers to add
              ChangeNotifierProvider(
                  create: (context) => WatchlistProvider(
                      auth: MockFirebaseAuth(),
                      store: FakeFirebaseFirestore())),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: GenericFilmCard(film),
              ),
            ),
          )));

      expect(find.text('Inception'), findsOneWidget);
    });

    testWidgets('navigates to film page on tap', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              //list of providers to add
              ChangeNotifierProvider(
                  create: (context) => WatchlistProvider(
                      auth: MockFirebaseAuth(),
                      store: FakeFirebaseFirestore())),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: GenericFilmCard(film),
              ),
            ),
          )));

      await tester.tap(find.byKey(const Key("genericFilmCard")));
      await tester.pumpAndSettle();

      expect(find.byType(FilmPage), findsOneWidget);
    });

    testWidgets('renders film type and year', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              //list of providers to add
              ChangeNotifierProvider(
                  create: (context) => WatchlistProvider(
                      auth: MockFirebaseAuth(),
                      store: FakeFirebaseFirestore())),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: GenericFilmCard(film),
              ),
            ),
          )));

      expect(find.text('Movie  •  2010'), findsOneWidget);
    });

    testWidgets('renders film image', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              //list of providers to add
              ChangeNotifierProvider(
                  create: (context) => WatchlistProvider(
                      auth: MockFirebaseAuth(),
                      store: FakeFirebaseFirestore())),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: GenericFilmCard(film),
              ),
            ),
          )));

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('navigates to film page with correct id', (tester) async {
      final mockObserver = MockNavigatorObserver();

      await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              //list of providers to add
              ChangeNotifierProvider(
                  create: (context) => WatchlistProvider(
                      auth: MockFirebaseAuth(),
                      store: FakeFirebaseFirestore())),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: GenericFilmCard(film),
              ),
              navigatorObservers: [mockObserver],
            ),
          )));

      await tester.tap(find.byType(Card));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(FilmPage), findsOneWidget);
    });

    testWidgets('displays film title with correct font style', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              //list of providers to add
              ChangeNotifierProvider(
                  create: (context) => WatchlistProvider(
                      auth: MockFirebaseAuth(),
                      store: FakeFirebaseFirestore())),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: GenericFilmCard(film),
              ),
            ),
          )));

      final titleFinder = find.text('Inception');
      final titleWidget = tester.widget<Text>(titleFinder);

      expect(titleWidget.style!.fontWeight, FontWeight.bold);
      expect(titleWidget.style!.fontSize, 22);
    });

    testWidgets('displays film type and year with correct font style',
        (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              //list of providers to add
              ChangeNotifierProvider(
                  create: (context) => WatchlistProvider(
                      auth: MockFirebaseAuth(),
                      store: FakeFirebaseFirestore())),
            ],
            child: MaterialApp(
              home: Scaffold(
                body: GenericFilmCard(film),
              ),
            ),
          )));

      final typeYearFinder = find.text('Movie  •  2010');
      final typeYearWidget = tester.widget<Text>(typeYearFinder);

      expect(typeYearWidget.style!.fontSize, 18);
    });
  });
}
