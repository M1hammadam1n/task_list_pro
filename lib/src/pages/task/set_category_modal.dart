import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class SelectSetDialog extends StatefulWidget {
  const SelectSetDialog({super.key});

  @override
  State<SelectSetDialog> createState() => _SelectSetDialogState();
}

class _SelectSetDialogState extends State<SelectSetDialog> {
  String _selectedCategory = 'No Category';

  final List<String> _categories = [
    'No Category',
    'Wishlist',
    'Work',
    'Birthday',
    'Personal',
    'Daily',
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF242443),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Set category",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: _categories.map((category) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4 - 40,
                  child: Row(
                    children: [
                      Radio<String>(
                        value: category,
                        groupValue: _selectedCategory,
                        fillColor: MaterialStateProperty.resolveWith<Color>((
                          states,
                        ) {
                          if (states.contains(MaterialState.selected)) {
                            return const Color(0xFF7A12FF); 
                          }
                          return Colors.white; 
                        }),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),

                      Expanded(
                        child: Text(
                          category,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FButton(
                  mainAxisSize: MainAxisSize.min,
                  onPress: () {
                    Navigator.of(context).pop(); // Закрыть без выбора
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                FButton(
                  mainAxisSize: MainAxisSize.min,
                  onPress: () {
                    // Логика сохранения выбранной категории
                    print('Selected category: $_selectedCategory');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
