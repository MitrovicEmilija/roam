import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:roam/core/common/error_text.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/features/trips/controller/trip_controller.dart';
import 'package:roam/models/trip_model.dart';

import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class TripsScreen extends ConsumerStatefulWidget {
  final String uid;
  const TripsScreen({super.key, required this.uid});

  @override
  ConsumerState<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends ConsumerState<TripsScreen> {
  void navigateToFriendsScreen(BuildContext context, String tripName) {
    Routemaster.of(context).push('/trip/friends/$tripName');
  }

  void deleteTrip(WidgetRef ref, BuildContext context, Trip trip) {
    ref.read(tripControllerProvider.notifier).deleteTrip(trip, context);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0).copyWith(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My trips',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: currentTheme.textTheme.displayLarge!.color,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ref.watch(userTripsProvider).when(
                    data: (fetchedTrips) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: fetchedTrips.length,
                        itemBuilder: (BuildContext context, int index) {
                          final trip = fetchedTrips[index];
                          return Card(
                            elevation: 5.0,
                            margin: const EdgeInsets.only(
                              bottom: 20,
                              right: 10,
                            ),
                            color: currentTheme.cardColor,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trip.name,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ), // Add space between trip name and date
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${DateFormat('d MMM').format(trip.dateFrom)} - ${DateFormat('d MMM').format(trip.dateTo)}',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: Pallete.yellow,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.person_add),
                                            onPressed: () {
                                              navigateToFriendsScreen(
                                                context,
                                                trip.name,
                                              );
                                            },
                                            color: Colors.blue,
                                            iconSize: 24,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              deleteTrip(ref, context, trip);
                                            },
                                            color: Colors.green,
                                            iconSize: 24,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ), // Add space between date and place name
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.blue,
                                        size: 16,
                                      ),
                                      Expanded(
                                        child: Text(
                                          trip.placeName,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: Colors.blue,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) =>
                        ErrorText(error: error.toString()),
                    loading: () => const Loader(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
