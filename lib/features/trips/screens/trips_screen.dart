import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:roam/core/common/error_text.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/features/trips/controller/trip_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0).copyWith(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My trips',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Pallete.lightGreen,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 500,
                child: ref.watch(tripsProvider).when(
                    data: (fetchedTrips) => (ListView.builder(
                          itemCount: fetchedTrips.length,
                          itemBuilder: (BuildContext context, int index) {
                            final trip = fetchedTrips[index];
                            return Card(
                              elevation: 4.0,
                              margin:
                                  const EdgeInsets.only(bottom: 20, right: 10),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Container(
                                      color: Pallete.lightBlue,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        trip.name,
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 50, 20, 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${DateFormat('d MMM').format(trip.dateFrom)} - ${DateFormat('d MMM').format(trip.dateTo)}',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            color: Pallete.yellow,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.person_add),
                                          onPressed: () {
                                            navigateToFriendsScreen(
                                                context, trip.name);
                                          },
                                          color: Pallete.blue,
                                          iconSize: 24,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            // Delete trip logic
                                          },
                                          color: Pallete.lightGreen,
                                          iconSize: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 10,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Pallete.blue,
                                          size: 16,
                                        ),
                                        Text(
                                          trip.placeName,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: Pallete.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )),
                    error: (error, stackTrace) =>
                        ErrorText(error: error.toString()),
                    loading: () => const Loader()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
