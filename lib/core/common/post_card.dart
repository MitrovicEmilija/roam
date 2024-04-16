import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/features/post/controller/post_controller.dart';
import 'package:roam/models/post_model.dart';
import 'package:roam/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  const PostCard({Key? key, required this.post}) : super(key: key);

  void deletePost(WidgetRef ref, BuildContext context) {
    ref.read(postControllerProvider.notifier).deletePost(post, context);
  }

  void navigateToUser(BuildContext context) {
    Routemaster.of(context).push('/u/${post.uid}');
  }

  void navigateToCommunity(BuildContext context) {
    Routemaster.of(context).push('/travel-community/${post.communityName}');
  }

  void navigateToComments(BuildContext context) {
    Routemaster.of(context).push('/post/${post.id}/comments');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final currentTheme = ref.watch(themeNotifierProvider);

    return Card(
      elevation: 4.0,
      color: currentTheme.cardColor,
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: GestureDetector(
              onTap: () {
                navigateToCommunity(context);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(post.communityProfilePic),
                radius: 20,
              ),
            ),
            title: Text(
              post.communityName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            subtitle: GestureDetector(
              onTap: () {
                navigateToUser(context);
              },
              child: Text(
                post.username,
                style: const TextStyle(fontSize: 12, color: Pallete.greyText),
              ),
            ),
            trailing: post.uid == user.uid
                ? IconButton(
                    onPressed: () {
                      deletePost(ref, context);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.green,
                    ),
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (post.type == 'image')
                  Image.network(
                    post.link!,
                    fit: BoxFit.cover,
                  ),
                if (post.type == 'link')
                  AnyLinkPreview(
                    displayDirection: UIDirection.uiDirectionHorizontal,
                    link: post.link!,
                  ),
                if (post.type == 'text')
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      post.description!,
                      style: const TextStyle(
                        color: Pallete.greyText,
                        fontFamily: 'Mulish',
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    navigateToComments(context);
                  },
                  icon: const Icon(
                    Icons.comment,
                    color: Colors.yellow,
                  ),
                ),
                Text(
                  '${post.commentCount == 0 ? 'Comment' : post.commentCount}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Mulish',
                    color: Pallete.greyText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
