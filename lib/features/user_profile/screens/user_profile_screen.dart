import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/common/error_text.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/features/community/controller/community_controller.dart';
import 'package:roam/models/community_model.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class UserProfileScreen extends ConsumerWidget {
  final String uid;
  const UserProfileScreen({super.key, required this.uid});

  void navigateToEditProfileScreen(BuildContext context) {
    Routemaster.of(context).push('/edit-profile/$uid');
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push('/travel-community/${community.name}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      body: ref.watch(getUserDataProvider(uid)).when(
            data: (user) => NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 250,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            color: currentTheme.scaffoldBackgroundColor,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding:
                              const EdgeInsets.all(20).copyWith(bottom: 70),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 45,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.all(15),
                          child: OutlinedButton(
                            onPressed: () =>
                                navigateToEditProfileScreen(context),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: currentTheme.primaryColorDark,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                            ),
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Pallete.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                user.username ?? 'No Username',
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins',
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              user.email ?? 'Google Email',
                              style: const TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(thickness: 2),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: ref.watch(userCommunityProvider).when(
                  data: (communities) => ListView.builder(
                        itemCount: communities.length,
                        itemBuilder: (BuildContext context, int index) {
                          final community = communities[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(community.avatar),
                            ),
                            title: Text(
                              community.name,
                              style: const TextStyle(
                                fontFamily: 'Mulish',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                            onTap: () {
                              navigateToCommunity(context, community);
                            },
                          );
                        },
                      ),
                  error: (error, stackTrace) =>
                      ErrorText(error: error.toString()),
                  loading: () => const Loader()),
            ),
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
