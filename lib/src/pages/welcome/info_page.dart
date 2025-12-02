import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maps_test/src/navigation/main_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2F),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset('assets/images/bro.png', width: 260),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        'Easy Time Management',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(
                      width: 300,
                      child: Text(
                        'With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF5F33E1),
                  ),
                  child: TextButton(
                    // onPressed: () {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (_) => const MainNavigation(),
                    //     ),
                    //   );
                    // },

onPressed: () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('first_launch', false);

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => const MainNavigation()),
  );
},

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 30),
                        const Text(
                          "Let's Start",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        SvgPicture.asset('assets/icons/Right.svg', width: 28),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
