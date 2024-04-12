import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:roam/core/constants/firebase_constants.dart';
import 'package:roam/core/failure.dart';
import 'package:roam/core/providers/firebase_providers.dart';
import 'package:roam/core/type_defs.dart';
import 'package:roam/models/trip_model.dart';

final tripRepositoryProvider = Provider((ref) {
  return TripRepository(firestore: ref.read(firestoreProvider));
});

class TripRepository {
  final FirebaseFirestore _firestore;

  TripRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _trips =>
      _firestore.collection(FirebaseConstants.tripsCollection);

  FutureVoid createTrip(Trip trip) async {
    try {
      var tripDoc = await _trips.doc(trip.name).get();
      if (tripDoc.exists) {
        throw 'Trip with the same name already exists.';
      }
      return right(_trips.doc(trip.name).set(trip.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Trip>> getTrips() {
    return _trips.snapshots().map((event) {
      List<Trip> trips = [];
      for (var doc in event.docs) {
        trips.add(Trip.fromMap(doc.data() as Map<String, dynamic>));
      }
      return trips;
    });
  }

  Future<void> addFriends(String tripName, List<String> userIds) async {
    try {
      var tripDoc = await _trips.doc(tripName).get();
      if (!tripDoc.exists) {
        throw 'The trip does not exist.';
      }

      for (final userId in userIds) {
        await _trips.doc(tripName).update({
          'members': FieldValue.arrayUnion([userId])
        });
      }
      await _trips.doc(tripName).update({'isSolo': false});
    } catch (e) {
      throw Failure('Failed to update trip with friends: $e');
    }
  }
}
