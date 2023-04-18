import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/authenticated_step.dart';
import 'steps/list_film_match.dart';
import 'steps/not_found.dart';
import 'steps/page_step.dart';
import 'steps/search_for_film.dart';
import 'steps/watchlist_tap_resemble.dart';

Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/feature/**.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
    ]
    ..stepDefinitions = [
      GivenUserAuthenticated(),
      GivenChangePageStep(),
      WhenSearchFilm(),
      ThenListFilmMatch(),
      ThenNotFound(),
      WhenWatchlistButtonTapResemble(),
      WhenChangePageStep(),
      ThenListFilmDoesntMatch()
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";
  return GherkinRunner().execute(config);
}