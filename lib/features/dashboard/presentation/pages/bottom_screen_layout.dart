import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/screens/bottom_screen.dart/home_screen.dart';
import 'package:tridivya_spritual_wellness_app/screens/bottom_screen.dart/profile_screen.dart';
import 'package:tridivya_spritual_wellness_app/screens/bottom_screen.dart/progress_screen.dart';
import 'package:tridivya_spritual_wellness_app/screens/bottom_screen.dart/sessions_screen.dart';


class BottomScreenLayout extends StatefulWidget {
  const BottomScreenLayout({super.key});

  @override
  State<BottomScreenLayout> createState() => _BottomScreenLayoutState();
}

class _BottomScreenLayoutState extends State<BottomScreenLayout> {
  int _selectedIndex = 0;

  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const SessionsScreen(),
    const ProgressScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Sessions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Progress',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
     
    );
  }
}
