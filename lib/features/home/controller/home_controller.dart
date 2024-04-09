import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/utils.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/features/home/repository/home_repository.dart';
import 'package:roam/models/place_model.dart';

final placesProvider = StreamProvider((ref) {
  final homeController = ref.watch(homeControllerProvider.notifier);
  return homeController.getPlaces();
});

final searchPlaceProvider = StreamProvider.family((ref, String query) {
  return ref.watch(homeControllerProvider.notifier).searchPlace(query);
});

final homeControllerProvider =
    StateNotifierProvider<HomeController, List<Place>>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);

  return HomeController(
    homeRepository: homeRepository,
    ref: ref,
  );
});

class HomeController extends StateNotifier<List<Place>> {
  final HomeRepository _homeRepository;
  final Ref _ref;

  HomeController({required HomeRepository homeRepository, required Ref ref})
      : _homeRepository = homeRepository,
        _ref = ref,
        super([]); // Initialize with an empty list

  Stream<List<Place>> getPlaces() {
    return _homeRepository.getPLaces();
  }

  Stream<List<Place>> searchPlace(String query) {
    return _homeRepository.searchPlace(query);
  }

  void fetchPlacesFromTrail() async {
    try {
      // Set loading state to true
      state = [];

      List<Place> places = await _homeRepository.fetchPlacesFromTrail();

      // Update fetched places
      state = places;

      if (kDebugMode) {
        print(state);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching places: $e');
      }
      rethrow;
    }
  }

  void storeToPreferences(String placeName, BuildContext context) async {
    final user = _ref.read(userProvider)!;
    state = [];
    final res = await _homeRepository.storeToPreferences(placeName, user.uid);
    res.fold((l) => showSnackBar(context, l.message),
        (r) => showSnackBar(context, 'Added to favourites.'));
  }

  void deleteFromPreferences(String placeName, BuildContext context) async {
    final user = _ref.read(userProvider)!;
    state = [];
    final res =
        await _homeRepository.deleteFromPreferences(placeName, user.uid);
    res.fold((l) => showSnackBar(context, l.message),
        (r) => showSnackBar(context, 'Removed from favourites.'));
  }
}
