import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class PlanTripScreen extends ConsumerStatefulWidget {
  final String name;

  const PlanTripScreen({super.key, required this.name});

  @override
  ConsumerState<PlanTripScreen> createState() => _PlanTripScreenState();
}

class _PlanTripScreenState extends ConsumerState<PlanTripScreen> {
  String? tripName;
  late DateTime selectedDate;
  String tripType = 'Solo';

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  void navigateToFriendsScreen(BuildContext context) {
    Routemaster.of(context).push('/trip/friends');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Plan Your Trip',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          color: Pallete.green,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Trip Name',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  tripName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Date: ${selectedDate.toLocal()}'.split(' ')[0],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Pallete.greyText,
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text(
                    'Select Date',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Pallete.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Type: ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Pallete.greyText,
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      tripType = 'Solo';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        tripType == 'Solo' ? Pallete.greyField : null,
                  ),
                  child: const Text(
                    'Solo',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Pallete.greyText,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    navigateToFriendsScreen(context);
                    setState(() {
                      tripType = 'With Friends';
                    });
                  },
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
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Plan my Trip',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Pallete.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Routemaster.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Pallete.greyText,
            ),
          ),
        ),
      ],
    );
  }
}
