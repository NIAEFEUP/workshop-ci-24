import 'dart:async';

import 'package:cinescope/controller/film_details_scraper.dart';
import 'package:cinescope/model/film.dart';
import 'package:cinescope/model/watchlist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class WatchlistProvider extends ChangeNotifier {
  late final FirebaseAuth _authInstance;
  late final FirebaseFirestore _storeInstance;

  WatchlistProvider({FirebaseAuth? auth, FirebaseFirestore? store}) 
    : _authInstance = auth ?? FirebaseAuth.instance, 
      _storeInstance = store ?? FirebaseFirestore.instance
  {
    _getWatchlist();
    _authInstance
        .authStateChanges()
        .asBroadcastStream(onListen: _authChange);
  }

  Watchlist _watchlist = Watchlist([]);
  Watchlist getWatchlist() => _watchlist;

  void _authChange(StreamSubscription<User?> subscription) async {
    final user = await subscription.asFuture() as User?;
    if (user != null) {
      await _getWatchlist();
    }
  }

  Future<void> _getWatchlist() async {
    if (_authInstance.currentUser != null) {
      final watchlistsRef = _storeInstance
          .collection("watchlists")
          .withConverter(
              fromFirestore: (snapshot, options) =>
                  Watchlist.fromFirestore(snapshot, options),
              toFirestore: (film, _) => film.toFirestore());
      _watchlist = (await watchlistsRef
              .doc(_authInstance.currentUser!.uid)
              .get())
          .data()!;
      await _watchlist.parseFilmsInWatchlist();
      notifyListeners();
    }
  }

  Future<void> addFilmToWatchlist(String filmId) async {
    if (_watchlist.movieIds.contains(filmId)) return;
    _watchlist.movieIds.add(filmId);
    final watchlistsRef = _storeInstance
        .collection("watchlists")
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Watchlist.fromFirestore(snapshot, options),
            toFirestore: (film, _) => film.toFirestore());
    notifyListeners();
    await watchlistsRef
        .doc(_authInstance.currentUser!.uid)
        .set(_watchlist);
    FilmDetailsScraper.getFilmDetails(filmId).then((value) {
      _watchlist.movies.add(value);
      notifyListeners();
    });
  }

  Future<void> removeFilmFromWatchlist(Film film) async {
    if (!_watchlist.movieIds.contains(film.id)) return;
    _watchlist.movieIds.remove(film.id);
    _watchlist.movies.remove(film);

    notifyListeners();
    final watchlistsRef = _storeInstance
        .collection("watchlists")
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Watchlist.fromFirestore(snapshot, options),
            toFirestore: (film, _) => film.toFirestore());

    await watchlistsRef
        .doc(_authInstance.currentUser!.uid)
        .set(_watchlist);
  }
}
