

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> registerCallback() async{
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference watchlists = FirebaseFirestore.instance.collection("watchlists");
  
  await watchlists.doc(userUid).set({"movies":[]});
  await watchlists.doc(userUid).set({"discussions":[]});
}