import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/common/error_text.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/features/home/controller/home_controller.dart';

import 'package:routemaster/routemaster.dart';

class SearchPlaceDelegate extends SearchDelegate {
  final WidgetRef ref;

  SearchPlaceDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchPlaceProvider(query)).when(
          data: (places) => ListView.builder(
            itemCount: places.length,
            itemBuilder: (BuildContext context, int index) {
              final place = places[index];
              return Card(
                elevation: 4.0,
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: SizedBox(
                    width: 100,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnyLinkPreview(
                        displayDirection: UIDirection.uiDirectionHorizontal,
                        link: place.webUrl,
                      ),
                    ),
                  ),
                  title: Text(place.name),
                  onTap: () => navigateToPlace(context, place.name),
                ),
              );
            },
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }

  void navigateToPlace(BuildContext context, String placeName) {
    Routemaster.of(context).push('/place/$placeName');
  }
}
