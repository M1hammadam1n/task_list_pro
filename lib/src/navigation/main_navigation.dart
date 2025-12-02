import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:maps_test/src/pages/calendar/calendar_page.dart';
import 'package:maps_test/src/pages/menu_left/menu_left.dart';
import 'package:maps_test/src/pages/profile/profile_page.dart';
import 'package:maps_test/src/pages/task/task_page.dart';

enum _SelectedTab { tasks, profile, calendar, menu }

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}
class _MainNavigationState extends State<MainNavigation> {
  _SelectedTab _selectedTab = _SelectedTab.values[1]; 
  final List<Widget> _pages = [
    MenuLeft(),   
    TaskPage(),
    ProfilePage(),
    CalendarPage(),
  ];

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = _SelectedTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _pages[_SelectedTab.values.indexOf(_selectedTab)],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              child: CrystalNavigationBar(
                currentIndex: _SelectedTab.values.indexOf(_selectedTab),
                unselectedItemColor: Colors.white70,
                backgroundColor: Colors.black.withOpacity(0.5),
                onTap: _handleIndexChanged,
                items: [ 
                  CrystalNavigationBarItem(
                    icon: Icons.menu,
                    selectedColor: Colors.white,
                  ),
                  CrystalNavigationBarItem(
                    icon: Icons.task_alt,
                    selectedColor: Colors.white,
                  ),
                  CrystalNavigationBarItem(
                    icon: Icons.person,
                    selectedColor: Colors.red,
                  ),
                  CrystalNavigationBarItem(
                    icon: Icons.calendar_today,
                    selectedColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
