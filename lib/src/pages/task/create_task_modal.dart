import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:maps_test/src/pages/task/category_selection_dialog.dart';
import 'package:maps_test/src/pages/task/set_date_time.dart';

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
                fontWeight: FontWeight.bold,
              ),
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
            const SizedBox(height: 20),
            const Row(
              children: [
                Text('  Add sub-task', style: TextStyle(color: Colors.grey)),
                Spacer(),
                Icon(Icons.add_box_outlined, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FButton(
                  mainAxisSize: MainAxisSize.min,
                  onPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => CategorySelectionDialog(),
                    ).then((selectedCategory) {
                      if (selectedCategory != null) {}
                    });
                  },
                  shortcuts: {
                    SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
                  },
                  actions: {
                    ActivateIntent: CallbackAction<ActivateIntent>(
                      onInvoke: (_) => null,
                    ),
                  },
                  child: const Text('Category'),
                ),
                FButton(
                  mainAxisSize: MainAxisSize.min,
                  onPress: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => const SetDateTime(),
                    );
                  },
                  child: const Text('Date & Time'),
                ),

                FButton(
                  mainAxisSize: MainAxisSize.min,
                  onPress: () {},
                  child: const Text('Set'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
