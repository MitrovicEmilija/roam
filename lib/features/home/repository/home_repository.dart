import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:roam/core/constants/firebase_constants.dart';
import 'package:roam/core/failure.dart';
import 'package:roam/core/providers/firebase_providers.dart';
import 'package:roam/core/type_defs.dart';
import 'package:roam/models/place_model.dart';

final homeRepositoryProvider = Provider((ref) {
  return HomeRepository(firestore: ref.read(firestoreProvider));
});

class HomeRepository {
  final FirebaseFirestore _firestore;

  HomeRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _places =>
      _firestore.collection(FirebaseConstants.placesCollection);

  FutureVoid savePlace(Place place) async {
    try {
      var placeDoc = await _places.doc(place.name).get();
      if (placeDoc.exists) {
        throw 'Place with the same name already exists.';
      }
      return right(_places.doc(place.name).set(place.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
