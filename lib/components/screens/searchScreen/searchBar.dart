import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white30,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          prefixIcon: Icon(Icons.search),
          labelText: 'Search',
          hintText: 'Search for posts',
        ),
      ),
    );
  }
}
