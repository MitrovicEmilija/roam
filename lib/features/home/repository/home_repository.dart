import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Future<List<Place>> fetchPlaces(String city) async {
    try {
      const apiKey = 'GuGZtV8WBlVY791b9I9l0g==vi1ujRdLX8yYacry';
      final url = 'https://api.api-ninjas.com/v1/geocoding?city=$city';

      final response = await http.get(
        Uri.parse(url),
        headers: {'X-Api-Key': apiKey},
      );

      List<dynamic> responseData = jsonDecode(response.body);

      List<Place> places = responseData.map((data) {
        return Place(
          name: data['name'] as String,
          latitude: (data['latitude'] as num).toDouble(),
          longitude: (data['longitude'] as num).toDouble(),
          country: data['country'] as String,
          rating: 3,
          isLiked: false,
        );
      }).toList();

      return places;
    } catch (e) {
      if (kDebugMode) print(e.toString().toUpperCase());
      return [];
    }
  }

  FutureVoid storeToPreferences(Place place, String userId) async {
    try {
      return right(_users.doc(userId).update({
        'preferences': FieldValue.arrayUnion([place]),
        'isLiked': true
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
