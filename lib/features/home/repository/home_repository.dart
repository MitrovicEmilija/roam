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

  CollectionReference get _places =>
      _firestore.collection(FirebaseConstants.placesCollection);

  FutureVoid storePlaces(List<Place> places) async {
    try {
      for (var place in places) {
        var existingDoc = await _places.doc(place.name).get();
        if (existingDoc.exists) {
          throw 'Place with the same name already exists.';
        }
        await _places.doc(place.name).set(place.toMap());
      }
      return right(null);
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<List<Place>> fetchPlacesFromTrail() async {
    const String apiKey = 'c2950de0e7394b69985196474fda0292';
    const String baseUrl =
        'https://api.geoapify.com/v2/places?categories=entertainment,catering,accommodation&filter=rect:2.3380862086841603,48.861868995221684,2.357539944586165,48.850557094041235&limit=20&apiKey=$apiKey';

    final Uri url = Uri.parse(baseUrl);
    // Make a GET request with headers
    try {
      final response = await http.get(url);

      print('Request Headers: ${response.headers}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<Place> places = [];

        // Check if the response contains features
        if (responseData.containsKey('features')) {
          // Extract features from the response
          final features = responseData['features'] as List<dynamic>;

          // Iterate over each feature and create a Place object
          for (final feature in features) {
            final properties = feature['properties'];
            final geometry = feature['geometry'];

            // Extract relevant properties for creating a Place object
            final name = properties['name'];
            final lat = geometry['coordinates'][1];
            final lon = geometry['coordinates'][0];
            final country = properties['country'];
            final webUrl = properties['website'];

            // Create a Place object and add it to the places list
            final place = Place(
              name: name,
              latitude: lat,
              longitude: lon,
              country: country,
              webUrl: webUrl,
              rating: 2,
              isLiked: false,
            );
            places.add(place);
          }
        }
        return places;
        // Store the fetched places into Firestore
        //await storePlaces(places);
      } else {
        throw 'Failed to fetch places: ${response.statusCode}';
      }
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
