import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen/home_screen.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen/meditation_screen.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen/yoga_screen.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen/mantra_screen.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/bottom_screen/library_screen.dart';


class BottomScreenLayout extends StatefulWidget {
  const BottomScreenLayout({this.initialIndex = 0, super.key});

  final int initialIndex;

  @override
  State<BottomScreenLayout> createState() => _BottomScreenLayoutState();
}

class _BottomScreenLayoutState extends State<BottomScreenLayout> {
  late int _selectedIndex = widget.initialIndex;

  List<Widget> lstBottomScreen = const [
    HomeScreen(),
    MeditationScreen(),
    YogaScreen(),
    MantraScreen(),
    LibraryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FF),
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.spa_outlined), label: 'Meditation'),
                BottomNavigationBarItem(icon: Icon(Icons.fitness_center_outlined), label: 'Yoga'),
                BottomNavigationBarItem(icon: Icon(Icons.music_note_outlined), label: 'Mantra'),
                BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Library'),
              ],
              unselectedItemColor: const Color(0xFF9AA3B5),
              selectedItemColor: const Color(0xFF7C4DFF),
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedFontSize: 12,
              unselectedFontSize: 12,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
