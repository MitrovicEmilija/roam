import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/common/error_text.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/core/common/star_rating.dart';
import 'package:roam/features/home/controller/home_controller.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class PlaceDetailsScreen extends ConsumerWidget {
  final String name;

  const PlaceDetailsScreen({super.key, required this.name});

  void navigateToPlanTrip(BuildContext context, String name) {
    Routemaster.of(context).push('/trip/$name');
  }

  void onRatingChanged(int rating, WidgetRef ref, BuildContext context) {
    ref.read(homeControllerProvider.notifier).ratePlace(rating, name, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getPlacesByNameProvider(name)).when(
            data: (place) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 250,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            color: Pallete.lightBlue,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding:
                              const EdgeInsets.all(20).copyWith(bottom: 40),
                          child: Text(
                            place.name,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 19,
                              color: Pallete.blue,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Pallete.yellow,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                place.country,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 17,
                                  color: Pallete.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${place.longitude.toStringAsFixed(4)}, ${place.latitude.toStringAsFixed(4)}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: AnyLinkPreview(
                                displayDirection:
                                    UIDirection.uiDirectionHorizontal,
                                link: place.webUrl,
                              )),
                          const SizedBox(height: 10),
                          const Divider(thickness: 2),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: Text(
                        'How much do you like it?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                          color: Pallete.green,
                        ),
                      ),
                    ),
                    StarRating(
                      ratings: place.rating,
                      onRatingChanged: (rating) {
                        onRatingChanged(rating, ref, context);
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                      onPressed: () => navigateToPlanTrip(context, place.name),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.blue,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Plan a trip',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Pallete.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
