import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final currentTheme = ref.watch(themeNotifierProvider);

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic),
              radius: 70,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              user.username ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                fontSize: 18,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'My Profile',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.person,
                color: currentTheme.iconTheme.color,
              ),
              onTap: () => navigateToUserProfile(context, user.uid),
            ),
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: currentTheme.iconTheme.color,
              ),
              onTap: () => logOut(ref),
            ),
            Switch.adaptive(
              value: ref.watch(themeNotifierProvider.notifier).mode ==
                  ThemeMode.dark,
              onChanged: (val) => toggleTheme(ref),
            ),
          ],
        ),
      ),
    );
  }
}
