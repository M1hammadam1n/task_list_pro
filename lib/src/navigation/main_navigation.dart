import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:maps_test/src/pages/calendar/calendar_page.dart';
import 'package:maps_test/src/pages/ai_assistant/ai_assistant.dart';
import 'package:maps_test/src/pages/profile/profile_page.dart';
import 'package:maps_test/src/pages/task/task_page.dart';

enum _SelectedTab { menu, tasks, calendar, profile }

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  _SelectedTab _selectedTab = _SelectedTab.values[1];
  final List<Widget> _pages = [
    AiAssistant(),
    TaskPage(),
    CalendarPage(),
    ProfilePage(),
  ];

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = _SelectedTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _SelectedTab.values.indexOf(_selectedTab);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: SizedBox(
                key: ValueKey<int>(selectedIndex),
                child: _pages[selectedIndex],
              ),
            ),
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
                currentIndex: selectedIndex,
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
                    icon: Icons.calendar_today,
                    selectedColor: Colors.white,
                  ),
                  CrystalNavigationBarItem(
                    icon: Icons.person,
                    selectedColor: Colors.red,
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
