import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roam/core/common/error_text.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class TripFriendsScreen extends ConsumerWidget {
  const TripFriendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            // Handle saving selected users
            Routemaster.of(context).pop();
          },
          child: const Text(
            'Save',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Pallete.blue,
              fontSize: 17,
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
              color: Pallete.greyText,
              fontSize: 17,
            ),
          ),
        ),
      ],
      title: const Text(
        'Add Friends as Contributors',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          color: Pallete.blue,
          fontSize: 20,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ref.watch(usersProvider).when(
            data: (users) {
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = users[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePic),
                      radius: 40,
                    ),
                    title: Text(
                      user.username!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    onTap: () {
                      // Handle user selection
                      // You may want to track selected users here
                    },
                  );
                },
              );
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader()),
      ),
    );
  }
}
