import 'package:flutter/material.dart';

class FavouritesScreen extends StatelessWidget {
  final String uid;
  const FavouritesScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text('Likes.'),
    );
  }
}
