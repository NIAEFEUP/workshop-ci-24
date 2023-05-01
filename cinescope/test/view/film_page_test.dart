import 'package:cinescope/controller/film_details_scraper.dart';
import 'package:cinescope/model/film.dart';
import 'package:cinescope/model/providers/watchlist_provider.dart';
import 'package:cinescope/model/watchlist.dart';
import 'package:cinescope/view/pages/film_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

import 'film_page_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<WatchlistProvider>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<FilmDetailsScraper>(onMissingStub: OnMissingStub.returnDefault)
  ],
)
void main() {
  group("FilmPage", () {
    final film =
        Film("1", 'Inception', 'Movie', 2010, 'https://via.placeholder.com/150',
            description: "Very nice movie",
            cast: {
              'https://via.placeholder.com/150': {
                "Robert Downey JR": ["Iron Man"]
              }
            },
            duration: "200 hours",
            rating: 10);
    testWidgets("renders correctly", (tester) async {
      WatchlistProvider mockProvider = MockWatchlistProvider();
      when(mockProvider.getWatchlist()).thenReturn(Watchlist([]));
      FilmDetailsScraper filmDetailsScraper = MockFilmDetailsScraper();
      when(filmDetailsScraper.getFilmDetails(film.id))
          .thenAnswer(((realInvocation) async {
        return film;
      }));
      //This is due to the test font, not an optimal solution, but it be reverted
      //when we will have our custom font
      final prevOnError = FlutterError.onError;
      FlutterError.onError = null;
      await mockNetworkImagesFor(() => tester.pumpWidget(MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => mockProvider)
            ],
            child: MaterialApp(
              home: Scaffold(
                body: FilmPage(
                  film.id,
                  filmDetailsScraper: filmDetailsScraper,
                ),
              ),
            ),
          )));
      await tester.pumpAndSettle();
      FlutterError.onError = prevOnError;

      expect(find.text(film.title), findsOneWidget);
      expect(find.text("Release Year: ${film.year}"), findsOneWidget);
      expect(find.text('Duration: ${film.duration}'), findsOneWidget);
      expect(find.text('Rating: ${film.rating}'), findsOneWidget);
    });
  });
}
