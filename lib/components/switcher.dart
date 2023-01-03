import 'package:flutter/material.dart';
import 'package:stata_app/components/screens/notifications.dart';
import 'screens/homeScreen/home.dart';
import 'screens/searchScreen/search.dart';
import 'screens/profile.dart';

class Switcher extends StatefulWidget {
  const Switcher({super.key});

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  int _navigationIndex = 0;

  static const List<Widget> _navigationOptions = <Widget>[
    Home(),
    Search(),
    Notifications(),
    Profile(),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _navigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _navigationOptions.elementAt(_navigationIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
          primaryColor: Colors.blue,
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
          currentIndex: _navigationIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontSize: 0),
          onTap: _onNavItemTapped,
        ),
      ),
    );
  }
}
