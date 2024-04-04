import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/theme/pallete.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final TextEditingController _cityController = TextEditingController();
  String name = '';
  double latitude = 0.0;
  double longitude = 0.0;
  String country = '';

  @override
  void initState() {
    super.initState();
    fetchPlaces();
  }

  List<Map<String, dynamic>> fetchedPlaces = [];

  Future<void> fetchPlaces() async {
    try {
      const apiKey = 'GuGZtV8WBlVY791b9I9l0g==vi1ujRdLX8yYacry';
      final city = _cityController.text;
      final url = 'https://api.api-ninjas.com/v1/geocoding?city=$city';

      final response = await http.get(
        Uri.parse(url),
        headers: {'X-Api-Key': apiKey},
      );

      List<dynamic> responseData = jsonDecode(response.body);

      List<Map<String, dynamic>> places =
          List<Map<String, dynamic>>.from(responseData);

      setState(() {
        fetchedPlaces = places;
      });
    } on Exception catch (e) {
      if (kDebugMode) print(e.toString().toUpperCase());
    }
  }

  @override
  Widget build(BuildContext context) {
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
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: 'Paris',
                hintStyle: TextStyle(
                  fontFamily: 'Mulish',
                  fontSize: 12,
                  color: Pallete.greyText,
                ),
                filled: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(18),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: fetchPlaces,
              child: const Text('Get place'),
            ),
            Center(
              child: SizedBox(
                width:
                    double.infinity, // Make the list fill the available width
                height: 300.0, // Adjust the height as needed
                child: ListView.builder(
                  itemCount: fetchedPlaces.length,
                  itemBuilder: (BuildContext context, int index) {
                    final place = fetchedPlaces[index];
                    return ListTile(
                      title: Text('Name: ${place['name']}'),
                      subtitle: Text(
                          'Latitude: ${place['latitude']}, Longitude: ${place['longitude']}, Country: ${place['country']}'),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
