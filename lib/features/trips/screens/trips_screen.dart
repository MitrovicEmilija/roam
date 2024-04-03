import 'package:flutter/material.dart';

class TripsScreen extends StatelessWidget {
  final String uid;
  const TripsScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text('My trips'),
    );
  }
}
