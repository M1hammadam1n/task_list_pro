
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

class CreateTaskDialog extends StatelessWidget {
  const CreateTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      backgroundColor: const Color(0xFF242443),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Create New Task",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Task Title",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF1A1A2F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            // const SizedBox(height: 16),
            // TextField(
            //   style: const TextStyle(color: Colors.white),
            //   maxLines: 5,
            //   decoration: InputDecoration(
            //     hintText: "Task Description",
            //     hintStyle: const TextStyle(color: Colors.white38),
            //     filled: true,
            //     fillColor: const Color(0xFF1A1A2F),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(12),
            //       borderSide: BorderSide.none,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 24),
         Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
  FButton(
  // style: FButtonStyle(),
  mainAxisSize: MainAxisSize.min,
  onPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  shortcuts: { SingleActivator(LogicalKeyboardKey.enter): ActivateIntent() },
  actions: { ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {}) },
  child: const Text('Button'),
),
  FButton(
    // style: FButtonStyle.outline(),
  mainAxisSize: MainAxisSize.min,
  onPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  shortcuts: { SingleActivator(LogicalKeyboardKey.enter): ActivateIntent() },
  actions: { ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {}) },
  child: const Text('Button'),
),
  FButton(
  // style: FButtonStyle(),
  mainAxisSize: MainAxisSize.min,
  onPress: () {},
  onSecondaryPress: () {},
  onSecondaryLongPress: () {},
  shortcuts: { SingleActivator(LogicalKeyboardKey.enter): ActivateIntent() },
  actions: { ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) {}) },
  child: const Text('Button'),
),
  ],
),

          ],
        ),
      ),
    );
  }
}