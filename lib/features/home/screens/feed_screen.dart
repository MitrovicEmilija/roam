import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:any_link_preview/any_link_preview.dart';

import 'package:roam/core/common/error_text.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/features/home/controller/home_controller.dart';
import 'package:roam/features/home/delegates/search_place_delegate.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  /*
  void fetchPlacesFromTrail(WidgetRef ref) {
    ref.read(homeControllerProvider.notifier).fetchPlacesFromTrail();
  }
  */

  void likePlace(WidgetRef ref, String placeName) {
    ref
        .read(homeControllerProvider.notifier)
        .storeToPreferences(placeName, context);
  }

  void dislikePlace(WidgetRef ref, String placeName) {
    ref
        .read(homeControllerProvider.notifier)
        .deleteFromPreferences(placeName, context);
  }

  void navigateToPlaceDetails(BuildContext context, String name) {
    Routemaster.of(context).push('/place-details/$name');
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Travel the world in grand style',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blue,
                      size: 40,
                    ),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: SearchPlaceDelegate(ref));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 500.0,
              child: ref.watch(placesProvider).when(
                    data: (fetchedPlaces) => ListView.builder(
                      itemCount: fetchedPlaces.length,
                      itemBuilder: (BuildContext context, int index) {
                        final place = fetchedPlaces[index];
                        return Card(
                          color: currentTheme.cardColor,
                          elevation: 4.0,
                          margin: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: AnyLinkPreview(
                                    displayDirection:
                                        UIDirection.uiDirectionHorizontal,
                                    link: place.webUrl,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () => navigateToPlaceDetails(
                                      context,
                                      place.name.trim(),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8),
                                        Text(
                                          place.name,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ), // Adjust spacing here
                                            Text(
                                              place.country,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            place.category,
                                            style: const TextStyle(
                                              fontFamily: 'Mulish',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                icon: place.isLiked
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.red,
                                                      )
                                                    : const Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.red,
                                                      ),
                                                onPressed: () {
                                                  if (place.isLiked) {
                                                    dislikePlace(
                                                        ref, place.name);
                                                  } else {
                                                    likePlace(ref, place.name);
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
