// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quadb/presentation/screens/home_screen.dart';
import 'package:quadb/presentation/screens/search_screen.dart';

class SkeletonScreen extends StatefulWidget {
  const SkeletonScreen({super.key});

  @override
  _SkeletonScreenState createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends State<SkeletonScreen> {
  int _selectedIndex = 0; // Track the selected tab index

  // List of screens to display in the tab bar
  final List<Widget> _screens = const [
    HomeScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.black.withOpacity(0.9),
        activeColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Icon(CupertinoIcons.home),
            ),
            label: '', // No label
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Icon(CupertinoIcons.search),
            ),
            label: '', // No label
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update selected index
          });
        },
      ),
      tabBuilder: (context, index) {
        return _screens[index]; // Display the selected screen
      },
    );
  }
}
