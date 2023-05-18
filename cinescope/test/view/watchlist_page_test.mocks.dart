// Mocks generated by Mockito 5.4.0 from annotations
// in cinescope/test/view/watchlist_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:ui' as _i6;

import 'package:cinescope/model/film.dart' as _i5;
import 'package:cinescope/model/providers/watchlist_provider.dart' as _i3;
import 'package:cinescope/model/watchlist.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWatchlist_0 extends _i1.SmartFake implements _i2.Watchlist {
  _FakeWatchlist_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WatchlistProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistProvider extends _i1.Mock implements _i3.WatchlistProvider {
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i2.Watchlist getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue: _FakeWatchlist_0(
          this,
          Invocation.method(
            #getWatchlist,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeWatchlist_0(
          this,
          Invocation.method(
            #getWatchlist,
            [],
          ),
        ),
      ) as _i2.Watchlist);
  @override
  _i4.Future<void> addFilmToWatchlist(String? filmId) => (super.noSuchMethod(
        Invocation.method(
          #addFilmToWatchlist,
          [filmId],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> removeFilmFromWatchlist(_i5.Film? film) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFilmFromWatchlist,
          [film],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void addListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}