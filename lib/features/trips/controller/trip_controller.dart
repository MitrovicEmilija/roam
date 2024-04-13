// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roam/core/utils.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/features/trips/repository/trip_repository.dart';
import 'package:roam/models/trip_model.dart';
import 'package:routemaster/routemaster.dart';

final userTripsProvider = StreamProvider((ref) {
  final tripController = ref.watch(tripControllerProvider.notifier);
  return tripController.getUserTrips();
});

final tripControllerProvider =
    StateNotifierProvider<TripController, List<Trip>>((ref) {
  final tripRepository = ref.watch(tripRepositoryProvider);

  return TripController(
    tripRepository: tripRepository,
    ref: ref,
  );
});

class TripController extends StateNotifier<List<Trip>> {
  final TripRepository _tripRepository;
  final Ref _ref;

  TripController({required TripRepository tripRepository, required Ref ref})
      : _tripRepository = tripRepository,
        _ref = ref,
        super([]);

  Stream<List<Trip>> getUserTrips() {
    final uid = _ref.read(userProvider)!.uid;
    return _tripRepository.getUserTrips(uid);
  }

  void createTrip(
    String name,
    String placeName,
    DateTime dateFrom,
    DateTime dateTo,
    bool isSolo,
    BuildContext context,
  ) async {
    final uid = _ref.read(userProvider)?.uid ?? '';

    Trip trip = Trip(
      id: name,
      placeName: placeName,
      name: name,
      dateFrom: dateFrom,
      dateTo: dateTo,
      isSolo: isSolo,
      creatorUid: uid,
      members: [uid],
    );

    final res = await _tripRepository.createTrip(trip);
    state = [trip];
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Trip created successfully');
      Routemaster.of(context).pop();
    });
  }

  void deleteTrip(Trip trip, BuildContext context) async {
    final res = await _tripRepository.deleteTrip(trip);
    res.fold(
        (l) => null, (r) => showSnackBar(context, 'Trip deleted successfuly.'));
  }

  void addFriends(
    String tripName,
    List<String> selectedUsers,
    BuildContext context,
  ) async {
    final res = await _tripRepository.addFriends(tripName, selectedUsers);
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Friends added.');
      Routemaster.of(context).pop();
    });
  }
}
