import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
     return const Scaffold(
      backgroundColor: Color(0xFF1A1A2F),
      body: SafeArea(
        child: Center(
          child: Text('CalendarPage'),
        ),
      ),
    );
  }
}