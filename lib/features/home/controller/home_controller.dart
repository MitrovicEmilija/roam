import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/providers/storage_repository_provider.dart';
import 'package:roam/features/home/repository/home_repository.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, bool>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  final storage = ref.watch(storageRepositoryProvider);

  return HomeController(
    homeRepository: homeRepository,
    storage: storage,
    ref: ref,
  );
});

class HomeController extends StateNotifier<bool> {
  final HomeRepository _homeRepository;

  HomeController(
      {required HomeRepository homeRepository,
      required StorageRepository storage,
      required Ref ref})
      : _homeRepository = homeRepository,
        super(false);
}

/*
  FutureVoid fetchAndSavePlaces(double latitude, double longitude) async {
    try {
      state = true;
      final placesData = await fetchPlacesFromApi(latitude, longitude);
      for (var placeData in placesData) {
        final place = Place.fromMap(placeData);
        await _homeRepository.savePlace(place);
      }
      state = false;
    } catch (e) {
      if (kDebugMode) print('Error fetching and saving places: $e');
      rethrow;
    }
  }
  */