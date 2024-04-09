import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityScreen extends ConsumerWidget {
  final String uid;
  const CommunityScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SizedBox(child: Text('Community feature'));
  }
}
