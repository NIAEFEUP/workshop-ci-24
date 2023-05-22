import 'dart:async';

import 'package:cinescope/model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider() {
    getProfileByUid();
    FirebaseAuth.instance
        .authStateChanges()
        .asBroadcastStream(onListen: _authChange);
  }

  Profile _profile = Profile.empty();
  Profile getProfile() => _profile;

  void _authChange(StreamSubscription<User?> subscription) async {
    final user = await subscription.asFuture() as User?;
    if (user != null) {
      await getProfileByUid();
    }
  }

  Future<Profile> getProfileByUid({String? uid}) async {
    final ownProfile = uid == null;
    uid ??= FirebaseAuth.instance.currentUser!.uid;
    final watchlistsRef = FirebaseFirestore.instance
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
        print(profile.picPath);
        profile.imageData =
            await FirebaseStorage.instance.ref(
            profile.picPath).getData();
      } catch (e) {
        print(e.toString());
      }
    }

    if (ownProfile) {
      _profile = profile!;
    }
    return profile!;
  }

  Future<Profile> getProfileByUidReload({String? uid}) async{
    final profile = await getProfileByUid(uid: uid);
    notifyListeners();
    return profile;
  }

  Future<void> saveProfile(Profile profile) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    profile.picPath = "images/profiles/${profile.id!}}.png";
    await firestore
        .collection('profiles')
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Profile.fromFirestore(snapshot, options),
            toFirestore: (film, _) => film.toFirestore())
        .doc(profile.id)
        .set(profile);
    if (profile.id == FirebaseAuth.instance.currentUser!.uid) {
      _profile = profile;
    }
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
