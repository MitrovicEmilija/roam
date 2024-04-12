import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/common/error_text.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/features/trips/controller/trip_controller.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class TripFriendsScreen extends ConsumerStatefulWidget {
  final String tripName;

  const TripFriendsScreen({Key? key, required this.tripName}) : super(key: key);

  @override
  ConsumerState createState() => _TripFriendsScreenState();
}

class _TripFriendsScreenState extends ConsumerState<TripFriendsScreen> {
  final List<String> selectedUserIds = [];

  void addFriends(BuildContext context, List<String> userIds, String tripName) {
    ref
        .read(tripControllerProvider.notifier)
        .addFriends(Uri.decodeComponent(widget.tripName), userIds, context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            addFriends(
              context,
              selectedUserIds,
              Uri.decodeComponent(widget.tripName),
            );
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
                    final isSelected = selectedUserIds.contains(user.uid);

                    return ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                        radius: 40,
                      ),
                      title: Text(
                        user.username!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Pallete.green : Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedUserIds.remove(user.uid);
                          } else {
                            selectedUserIds.add(user.uid);
                          }
                        });
                      },
                      trailing: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Pallete.green,
                            )
                          : null,
                    );
                  },
                );
              },
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
