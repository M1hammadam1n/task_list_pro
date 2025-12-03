import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:maps_test/src/pages/welcome/welcome_page.dart';
import 'package:maps_test/src/navigation/main_navigation.dart';

class MainLoader extends StatefulWidget {
  const MainLoader({super.key});

  @override
  State<MainLoader> createState() => _MainLoaderState();
}

class _MainLoaderState extends State<MainLoader> {
  bool _isLoading = true;
  bool _isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _isFirstLaunch = prefs.getBool('first_launch') ?? true;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF1A1A2F),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    return _isFirstLaunch ? const WelcomePage() : const MainNavigation();
  }
}
