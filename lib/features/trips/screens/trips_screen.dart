import 'package:flutter/material.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class TripsScreen extends StatelessWidget {
  final String uid;
  const TripsScreen({super.key, required this.uid});

  void navigateToFriendsScreen(BuildContext context, String tripName) {
    Routemaster.of(context).push('/trip/friends/$tripName');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Pallete.blue,
        ),
        child: const Text(
          'With Friends',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Pallete.white,
          ),
        ),
      ),
    );
  }
}
