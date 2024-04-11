import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:roam/features/trips/controller/trip_controller.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class PlanTripScreen extends ConsumerStatefulWidget {
  final String name;

  const PlanTripScreen({super.key, required this.name});

  @override
  ConsumerState<PlanTripScreen> createState() => _PlanTripScreenState();
}

class _PlanTripScreenState extends ConsumerState<PlanTripScreen> {
  final tripNameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isSolo = true;

  @override
  void dispose() {
    super.dispose();
    tripNameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  void planTrip() {
    ref.read(tripControllerProvider.notifier).createTrip(
          tripNameController.text.trim(),
          Uri.decodeComponent(widget.name),
          selectedDate,
          isSolo,
          context,
        );
  }

  Future<void> selectDate(BuildContext context) async {
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
              controller: tripNameController,
              decoration: const InputDecoration(
                labelText: 'Trip Name',
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Pallete.greyText,
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () => selectDate(context),
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => planTrip(),
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
