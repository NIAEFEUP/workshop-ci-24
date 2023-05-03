import 'dart:async';

import 'package:cinescope/model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider() {
    _getProfile();
    FirebaseAuth.instance
        .authStateChanges()
        .asBroadcastStream(onListen: _authChange);
  }

  Profile _profile = Profile.empty();
  Profile getProfile() => _profile;

  void _authChange(StreamSubscription<User?> subscription) async {
    final user = await subscription.asFuture() as User?;
    if (user != null) {
      await _getProfile();
    }
  }

  Future<void> _getProfile() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final watchlistsRef = FirebaseFirestore.instance
          .collection("profiles")
          .withConverter(
              fromFirestore: (snapshot, options) =>
                  Profile.fromFirestore(snapshot, options),
              toFirestore: (film, _) => film.toFirestore());
      _profile = (await watchlistsRef
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get())
          .data()!;
      notifyListeners();
      _profile.imageData =
          await FirebaseStorage.instance.ref(_profile.picPath).getData();
      notifyListeners();
    }
  }

  Future<void> saveProfile(Profile profile) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    profile.picPath =
        "images/profiles/${FirebaseAuth.instance.currentUser!.uid}.png";
    await firestore
        .collection('profiles')
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Profile.fromFirestore(snapshot, options),
            toFirestore: (film, _) => film.toFirestore())
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(profile);
    notifyListeners();
    await FirebaseStorage.instance
        .ref(profile.picPath)
        .putData(profile.imageData!);
    notifyListeners();
  }

  void rerender() {
    notifyListeners();
  }
}
