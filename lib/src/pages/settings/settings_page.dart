import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2F),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A2F),
        title: Text("Settings", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.access_time, color: Colors.white),
            title: Text("Date & Time", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.tune, color: Colors.white),
            title: Text("Customize", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.format_paint, color: Colors.white),
            title: Text(
              "Task appearance customize",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {},
          ),
          Divider(),
        ],
      ),
    );
  }
}
