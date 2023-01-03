import 'package:flutter/material.dart';

import 'map.dart';
import 'searchBar.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Search"),
      ),
      body: Stack(
        children: const <Widget>[
          Map(),
          SearchBar(),
        ],
      ),
    );
  }
}
