// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class createModal extends StatefulWidget {
  const createModal({super.key});

  @override
  State<createModal> createState() => _createModalState();
}

class _createModalState extends State<createModal> {
  final postController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Create'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: postController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white30,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  labelText: 'Post',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final post = postController.text;
                if (user.displayName == "") {
                  createPost(name: user.email!, post: post);
                } else {
                  createPost(name: user.displayName!, post: post);
                }
                Navigator.pop(context);
              },
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('close'),
            ),
          ],
        ),
      ),
    );
  }

  Future createPost({required String name, required String post}) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc();

    Position currentPosition = await Utils.getUserLocation();

    final json = {
      'name': name,
      'post': post,
      'lat': currentPosition.latitude,
      'long': currentPosition.longitude,
    };

    await docPost.set(json);
  }
}
