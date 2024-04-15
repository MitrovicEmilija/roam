import 'package:flutter/material.dart';

import 'package:roam/features/auth/screens/auth_screen.dart';
import 'package:roam/features/community/screens/add_mods_screen.dart';
import 'package:roam/features/community/screens/community_screen.dart';
import 'package:roam/features/community/screens/create_community_screen.dart';
import 'package:roam/features/community/screens/edit_community_screen.dart';
import 'package:roam/features/community/screens/mod_tools_screen.dart';
import 'package:roam/features/home/screens/place_details_screen.dart';
import 'package:roam/features/post/screens/add_post_type_screen.dart';
import 'package:roam/features/post/screens/comment_screen.dart';
import 'package:roam/features/trips/screens/plan_trip_screen.dart';
import 'package:roam/features/trips/screens/trip_friends_screen.dart';
import 'package:roam/features/trips/screens/trips_screen.dart';
import 'package:roam/features/user_profile/screens/edit_profile_screen.dart';
import 'package:roam/features/user_profile/screens/user_profile_screen.dart';
import 'package:roam/features/home/screens/home_screen.dart';

import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: AuthScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(
        child: HomeScreen(),
      ),
  '/community/:uid': (routeData) => MaterialPage(
        child: CreateCommunityScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/travel-community/:name': (route) => MaterialPage(
        child: CommunityScreen(name: route.pathParameters['name']!),
      ),
  '/mod-tools/:name': (routeData) => MaterialPage(
        child: ModToolsScreen(name: routeData.pathParameters['name']!),
      ),
  '/add-mods/:name': (routeData) => MaterialPage(
        child: AddModsScreen(name: routeData.pathParameters['name']!),
      ),
  '/trips/:uid': (routeData) => MaterialPage(
        child: TripsScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/trip/:name': (routeData) => MaterialPage(
        child: PlanTripScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/trip/friends/:tripName': (routeData) => MaterialPage(
        child:
            TripFriendsScreen(tripName: routeData.pathParameters['tripName']!),
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
  '/edit-community/:name': (routeData) => MaterialPage(
        child: EditCommunityScreen(name: routeData.pathParameters['name']!),
      ),
  '/place-details/:name': (routeData) => MaterialPage(
        child: PlaceDetailsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/add-post/:type': (routeData) => MaterialPage(
        child: AddPostTypeScreen(
          type: routeData.pathParameters['type']!,
        ),
      ),
  '/post/:postId/comments': (routeData) => MaterialPage(
        child: CommentsScreen(
          postId: routeData.pathParameters['postId']!,
        ),
      ),
});
