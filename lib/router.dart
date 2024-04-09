import 'package:flutter/material.dart';
import 'package:roam/features/auth/screens/auth_screen.dart';
import 'package:roam/features/community/screens/community_screen.dart';
import 'package:roam/features/trips/screens/trips_screen.dart';
import 'package:roam/features/user_profile/screens/edit_profile_screen.dart';
import 'package:roam/features/user_profile/screens/user_profile_screen.dart';
import 'package:roam/features/home/screens/home_screen.dart';

import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: AuthScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/community/:uid': (routeData) => MaterialPage(
        child: CommunityScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/trips/:uid': (routeData) => MaterialPage(
        child: TripsScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/u/:uid': (routeData) => MaterialPage(
        child: UserProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (routeData) => MaterialPage(
        child: EditProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  //'/place/:placeId': (routeData) => MaterialPage(child: child)
});
