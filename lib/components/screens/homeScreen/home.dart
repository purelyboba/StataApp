import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'createModal.dart';
import 'post.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Widget> generatedPosts;

  @override
  void initState() {
    super.initState();
    generatedPosts = generatePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Home"),
      ),
      body: RefreshIndicator(
        onRefresh: refreshPostData,
        child: FutureBuilder(
          future: generatedPosts,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return snapshot.data;
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const createModal();
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> refreshPostData() async {
    setState(() {
      generatedPosts = generatePosts();
    });
  }

  Future<Map<String, PostData>> getPostData() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection("posts");

    var querySnapshot = await collection.get();

    Map<String, PostData> allPosts = <String, PostData>{};

    for (var document in querySnapshot.docs) {
      // print(document.get('name'));
      // print(document.get('post'));
      // print(document.data());
      PostData post =
          PostData(name: document.get('name'), post: document.get('post'));
      allPosts.putIfAbsent(document.id, () => post);
    }

    return allPosts;
  }

  Future<Widget> generatePosts() async {
    Map<String, PostData> allPosts = await getPostData();

    List<Widget> postWidgets = [];
    for (String key in allPosts.keys) {
      PostData? post = allPosts[key];
      if (post != null) {
        Widget postWidget = Post(
          name: post.name,
          post: post.post,
        );

        postWidgets.add(postWidget);
      }
    }

    return ListView(
      children: postWidgets,
    );
  }
}

class PostData {
  final String name;
  final String post;

  PostData({required this.name, required this.post});

  @override
  String toString() {
    return ("$name: $post");
  }
}
