import 'package:flutter/material.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class ModToolsScreen extends StatelessWidget {
  final String name;
  const ModToolsScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  void navigateToEditCommunity(BuildContext context) {
    Routemaster.of(context).push('/edit-community/$name');
  }

  void navigateToAddMods(BuildContext context) {
    Routemaster.of(context).push('/add-mods/$name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mod Tools',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Pallete.blue,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.add_moderator),
            title: const Text(
              'Add Moderators',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 16,
                color: Pallete.greyText,
              ),
            ),
            onTap: () {
              navigateToAddMods(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(
              'Edit Community',
              style: TextStyle(
                fontFamily: 'Mulish',
                fontSize: 16,
                color: Pallete.greyText,
              ),
            ),
            onTap: () {
              navigateToEditCommunity(context);
            },
          )
        ],
      ),
    );
  }
}
