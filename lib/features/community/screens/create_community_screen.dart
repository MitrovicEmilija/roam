import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:roam/core/common/loader.dart';
import 'package:roam/features/community/controller/community_controller.dart';
import 'package:roam/features/home/delegates/search_community_delegate.dart';
import 'package:roam/theme/pallete.dart';

class CreateCommunityScreen extends ConsumerStatefulWidget {
  final String uid;
  const CreateCommunityScreen({super.key, required this.uid});

  @override
  ConsumerState<CreateCommunityScreen> createState() =>
      _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends ConsumerState<CreateCommunityScreen> {
  final communityNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    communityNameController.dispose();
  }

  void createCommunity() {
    ref
        .read(communityControllerProvider.notifier)
        .createCommunity(communityNameController.text.trim(), context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'Create a community',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Pallete.lightGreen,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(18.0).copyWith(top: 5),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Community name',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Pallete.greyText,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: communityNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter a name',
                            hintStyle: const TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 15,
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.all(18),
                          ),
                          maxLength: 21,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 23),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Pallete.lightGreen,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 30,
                              color: Pallete.white,
                            ),
                            onPressed: () {
                              showSearch(
                                  context: context,
                                  delegate: SearchCommunityDelegate(ref));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  ElevatedButton(
                    onPressed: createCommunity,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        minimumSize: const Size(double.infinity, 50)),
                    child: const Text(
                      'Create community',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Pallete.lightGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
