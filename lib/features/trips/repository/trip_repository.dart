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

  FutureVoid deleteTrip(Trip trip) async {
    try {
      return right(_trips.doc(Uri.decodeComponent(trip.name)).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Trip>> getUserTrips(String uid) {
    return _trips.where('members', arrayContains: uid).snapshots().map((event) {
      List<Trip> trips = [];
      for (var doc in event.docs) {
        final data = doc.data() as Map<String, dynamic>;
        // Check if the user is both a creator and a member
        if (data['creatorUid'] == uid && data['members'].contains(uid)) {
          trips.add(Trip.fromMap(data));
        }
      }
      return trips;
    });
  }

  FutureVoid addFriends(String tripName, List<String> userIds) async {
    try {
      for (final userId in userIds) {
        await _trips.doc(Uri.decodeComponent(tripName)).update({
          'members': FieldValue.arrayUnion([userId])
        });
      }
      await _trips.doc(tripName).update({'isSolo': false});
      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
