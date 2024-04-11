// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roam/core/utils.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/features/trips/repository/trip_repository.dart';
import 'package:roam/models/trip_model.dart';
import 'package:routemaster/routemaster.dart';

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

  void createTrip(
    String name,
    String placeName,
    DateTime date,
    bool isSolo,
    BuildContext context,
  ) async {
    final uid = _ref.read(userProvider)?.uid ?? '';

    Trip trip = Trip(
      id: name,
      placeName: placeName,
      name: name,
      date: date,
      isSolo: isSolo,
      members: [uid],
    );

    final res = await _tripRepository.createTrip(trip);
    state = [trip];
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Trip created successfully');
      Routemaster.of(context).pop();
    });
  }

  void addFriends(
      String tripName, List<String> selectedUsers, BuildContext context) async {
    try {
      final List<String> members = [...selectedUsers];
      final userId = _ref.read(userProvider)?.uid;

      if (userId != null && !members.contains(userId)) {
        members.add(userId);
      }
      await _tripRepository.addFriends(tripName, members);

      showSnackBar(context, 'Friends selected and trip is created.');
    } catch (e) {
      showSnackBar(context, 'Error: $e');
    }
  }
}
