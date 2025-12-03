import 'package:flutter/material.dart';
import 'package:maps_test/src/pages/task/create_new_category_dialog.dart';

class CategorySelectionDialog extends StatelessWidget {
  const CategorySelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'Grocery',
        'icon': Icons.local_grocery_store,
        'color': const Color(0xFFCCFF80),
      },
      {
        'name': 'Work',
        'icon': Icons.work_outline,
        'color': const Color(0xFFFF9680),
      },
      {
        'name': 'Sport',
        'icon': Icons.fitness_center,
        'color': const Color(0xFF80FFFF),
      },
      {
        'name': 'Design',
        'icon': Icons.design_services,
        'color': const Color(0xFF80FFD9),
      },
      {
        'name': 'University',
        'icon': Icons.school,
        'color': const Color(0xFF809CFF),
      },
      {
        'name': 'Social',
        'icon': Icons.campaign,
        'color': const Color(0xFFFF80EB),
      },
      {
        'name': 'Music',
        'icon': Icons.music_note,
        'color': const Color(0xFFFC80FF),
      },
      {
        'name': 'Health',
        'icon': Icons.favorite_border,
        'color': const Color(0xFF80FFA3),
      },
      {'name': 'Movie', 'icon': Icons.movie, 'color': const Color(0xFF80D1FF)},
      {'name': 'Home', 'icon': Icons.home, 'color': const Color(0xFFFFCC80)},
    ];

    return Dialog(
      backgroundColor: const Color(0xFF242443),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            const Text(
              "Choose Category",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white12),
            const SizedBox(height: 10),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.85,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(cat);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: cat['color'],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            cat['icon'],
                            color: Colors.black87,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cat['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (innerContext) => const CreateNewCategoryDialog(),
                  ).then((newCategoryTitle) {
                    if (newCategoryTitle != null &&
                        newCategoryTitle.isNotEmpty) {}
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: Color(0xFF673AB7), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  'Create New',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
