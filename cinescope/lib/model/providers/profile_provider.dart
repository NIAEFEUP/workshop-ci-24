import 'dart:async';

import 'package:cinescope/model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  ProfileProvider(
      {FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firebaseFirestore,
      FirebaseStorage? firebaseStorage})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance {
    if(_firebaseAuth.currentUser != null){
      getProfileByUid();
    }
    _firebaseAuth.authStateChanges().listen(_authChange);
  }

  Profile _profile = Profile.empty();
  Profile getProfile() => _profile;

  void _authChange(User? user) async {
    if (user != null) {
      _profile = await getProfileByUid();
    }
  }

  Future<Profile> getProfileByUid({String? uid}) async {
    final ownProfile = uid == null;
    uid ??= _firebaseAuth.currentUser!.uid;
    final watchlistsRef = _firebaseFirestore
        .collection("profiles")
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Profile.fromFirestore(snapshot, options),
            toFirestore: (film, _) => film.toFirestore());
    Profile? profile = (await watchlistsRef.doc(uid).get()).data();
    if (profile == null && ownProfile) {
      profile = Profile.empty();
      profile.id ??= ownProfile ? uid : null;
    } else if (profile != null) {
      try {
        profile.imageData =
            await _firebaseStorage.ref(profile.picPath).getData();
      } catch (e) {
        print("exception...");
        print(e.toString());
      }
    }

    if (ownProfile) {
      _profile = profile!;
    }
    return profile!;
  }

  Future<Profile> getProfileByUidReload({String? uid}) async {
    final profile = await getProfileByUid(uid: uid);
    notifyListeners();
    return profile;
  }

  Future<void> saveProfile(Profile profile) async {
    FirebaseFirestore firestore = _firebaseFirestore;

    profile.picPath = "images/profiles/${profile.id!}.png";
    await firestore
        .collection('profiles')
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Profile.fromFirestore(snapshot, options),
            toFirestore: (film, _) => film.toFirestore())
        .doc(profile.id)
        .set(profile);
    if (profile.id == _firebaseAuth.currentUser!.uid) {
      _profile = profile;
    }
    notifyListeners();
    await _firebaseStorage
        .ref(profile.picPath)
        .putData(profile.imageData!);
    notifyListeners();
  }

  void rerender() {
    notifyListeners();
  }
}
