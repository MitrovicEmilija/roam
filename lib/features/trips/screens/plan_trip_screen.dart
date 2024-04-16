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
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();
  bool isSolo = true;

  @override
  void dispose() {
    super.dispose();
    tripNameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedFromDate = DateTime.now();
    selectedToDate = DateTime.now();
  }

  void planTrip() {
    ref.read(tripControllerProvider.notifier).createTrip(
          tripNameController.text.trim(),
          Uri.decodeComponent(widget.name),
          selectedFromDate,
          selectedToDate,
          isSolo,
          context,
        );
  }

  Future<void> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedFromDate) {
      setState(() {
        selectedFromDate = picked;
      });
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedFromDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedToDate) {
      setState(() {
        selectedToDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);

    return AlertDialog(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      title: const Text(
        'Plan Your Trip',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          color: Colors.green,
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
                const Text(
                  'From: ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Pallete.greyText,
                  ),
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(selectedFromDate),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Pallete.yellow,
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () => selectFromDate(context),
                  child: const Text(
                    'Select Date',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'To: ',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Pallete.greyText,
                  ),
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(selectedToDate),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Pallete.yellow,
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () => selectToDate(context),
                  child: const Text(
                    'Select Date',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.green,
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
          onPressed: () => planTrip(),
          child: const Text(
            'Plan my Trip',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.blueGrey,
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
              color: Pallete.yellow,
            ),
          ),
        ),
      ],
    );
  }
}
