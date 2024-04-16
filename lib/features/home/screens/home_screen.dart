import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/constants/constants.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/features/home/screens/profile_drawer.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _page = 0;

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void navigateToNotifications() {
    Routemaster.of(context).push('/notifications');
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              navigateToNotifications();
            },
            icon: const Icon(
              Icons.notifications,
              color: Colors.blue,
              size: 25,
            ),
          ),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => displayEndDrawer(context),
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
            );
          })
        ],
      ),
      endDrawer: const ProfileDrawer(),
      body: Constants.tabWidgets[_page],
      bottomNavigationBar: CupertinoTabBar(
        activeColor: currentTheme.primaryColorDark,
        backgroundColor: currentTheme.scaffoldBackgroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.luggage),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: '',
          ),
        ],
        onTap: onPageChanged,
        currentIndex: _page,
      ),
    );
  }
}
