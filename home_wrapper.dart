import 'package:flutter/material.dart';
import 'package:smily/features/Blogs/screens/blog_screen.dart';
import 'package:smily/features/home/home_screen.dart';
import 'package:smily/features/home/profile_screen.dart';
import 'package:smily/widgets/custom_bottom_nav.dart';

class HomeWrapper extends StatefulWidget {
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    BlogsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
