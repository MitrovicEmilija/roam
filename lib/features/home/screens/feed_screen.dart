import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/common/star_rating.dart';
import 'package:roam/features/home/controller/home_controller.dart';
import 'package:roam/models/place_model.dart';
import 'package:roam/theme/pallete.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final TextEditingController _cityController = TextEditingController();

  void fetchPlaces(WidgetRef ref, String city) {
    ref.read(homeControllerProvider.notifier).fetchPlaces(city);
  }

  void likePlace(WidgetRef ref, Place place) {
    ref
        .read(homeControllerProvider.notifier)
        .storeToPreferences(place, context);
  }

  @override
  Widget build(BuildContext context) {
    List<Place> fetchedPlaces = ref.watch(homeControllerProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Travel the world in grand style',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Pallete.lightGreen,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: 'Paris',
                      hintStyle: const TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 12,
                        color: Pallete.greyText,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(18),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      fetchPlaces(ref, _cityController.text.trim());
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    fixedSize: const Size(50, 50),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 300.0,
              child: ListView.builder(
                itemCount: fetchedPlaces.length,
                itemBuilder: (BuildContext context, int index) {
                  final place = fetchedPlaces[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            place.name,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          subtitle: Text(
                            place.country,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Pallete.blue,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.location_on,
                            color: Pallete.blue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StarRating(
                                rating: 3,
                                onRatingChanged: (rating) {},
                              ),
                              IconButton(
                                icon: place.isLiked
                                    ? const Icon(Icons.favorite)
                                    : const Icon(Icons.favorite_border),
                                onPressed: () => likePlace(ref, place),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
