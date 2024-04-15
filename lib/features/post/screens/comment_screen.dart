import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/common/comment_card.dart';
import 'package:roam/core/common/error_text.dart';
import 'package:roam/core/common/loader.dart';
import 'package:roam/core/common/post_card.dart';
import 'package:roam/features/auth/controller/auth_controller.dart';
import 'package:roam/features/post/controller/post_controller.dart';
import 'package:roam/models/post_model.dart';

class CommentsScreen extends ConsumerStatefulWidget {
  final String postId;
  const CommentsScreen({super.key, required this.postId});

  @override
  ConsumerState<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  void addComment(Post post) {
    ref.read(postControllerProvider.notifier).addComment(
          context: context,
          text: commentController.text.trim(),
          post: post,
        );
    setState(() {
      commentController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ref.watch(getPostByIdProvider(widget.postId)).when(
              data: (post) {
                return Column(
                  children: [
                    PostCard(post: post),
                    if (!isGuest)
                      TextField(
                        onSubmitted: (val) => addComment(post),
                        controller: commentController,
                        decoration: const InputDecoration(
                          hintText: 'What are your thoughts?',
                          hintStyle: TextStyle(fontFamily: 'Mulish'),
                          filled: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ref.read(getPostCommentsProvider(widget.postId)).when(
                          data: (comments) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: comments.length,
                              itemBuilder: (BuildContext context, int index) {
                                final comment = comments[index];
                                return CommentCard(comment: comment);
                              },
                            );
                          },
                          error: (error, stackTrace) => ErrorText(
                            error: error.toString(),
                          ),
                          loading: () => const Loader(),
                        ),
                  ],
                );
              },
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
