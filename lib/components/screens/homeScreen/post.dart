import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String name;
  final String post;

  const Post({super.key, required this.name, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(post),
        ],
      ),
    );

    // return Column(
    //   children: [
    //     Text(name),
    //     Text(post),
    //   ],
    // );
  }
}
