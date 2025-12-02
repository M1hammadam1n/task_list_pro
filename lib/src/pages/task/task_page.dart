import 'package:flutter/material.dart';
import 'package:maps_test/src/pages/task/create_task_modal.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class TaskItemData {
  final String title;
  final String date;
  final Color statusColor;
  final bool isCompleted;

  bool isOpen;

  TaskItemData({
    required this.title,
    required this.date,
    required this.statusColor,
    required this.isCompleted,
    this.isOpen = false,
  });
}

class TaskSectionData {
  final String title;
  final bool initiallyExpanded;
  final bool hasAddButton;
  final List<TaskItemData>? subtasks;

  bool showAllTasks;

  TaskSectionData({
    required this.title,
    this.initiallyExpanded = false,
    this.hasAddButton = false,
    this.subtasks,
    this.showAllTasks = false,
  });
}

class _TaskPageState extends State<TaskPage> {
  List<TaskSectionData> sectionsData = [
    TaskSectionData(
      title: 'Previous Tasks',
      initiallyExpanded: false,
      subtasks: [
        TaskItemData(
            title: 'Title-1',
            date: '14/12/22',
            statusColor: Colors.amber,
            isCompleted: true),
        TaskItemData(
            title: 'Title-2',
            date: '12/12/22',
            statusColor: Colors.teal,
            isCompleted: true),
        TaskItemData(
          title: 'Title-3',
          date: '03/12/22',
          statusColor: Color(0xFF5F33E1),
          isCompleted: false,
        ),
        TaskItemData(
          title: 'Title-4',
          date: '03/12/22',
          statusColor: Color(0xFF5F33E1),
          isCompleted: false,
        ),
        TaskItemData(
          title: 'Title-5',
          date: '03/12/22',
          statusColor: Color(0xFF5F33E1),
          isCompleted: false,
        ),
      ],
    ),
    TaskSectionData(title: 'Today Tasks', subtasks: []),
    TaskSectionData(title: 'Categories', hasAddButton: true),
    TaskSectionData(title: 'Completed Tasks', subtasks: []),
  ];

  final Map<int, bool> _isExpanded = {};
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _closeSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  Widget _buildTaskDetails(TaskItemData task) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2F),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Description",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Это подробное описание задачи. Здесь можно разместить любые данные, заметки, чеклист и т.д.",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          const Text(
            "Notes",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Задачу нужно выполнить до конца недели.",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5F33E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2F),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF242443),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            border: const Border(
              bottom: BorderSide(color: Color(0xFF7a12ff), width: 2),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
              child: _isSearching
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A2F),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Search Tasks...',
                                hintStyle: const TextStyle(
                                    color: Color(0xFFA1A1C1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  onPressed: _closeSearch,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search,
                                      color: Colors.white),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage('https://i.pravatar.cc/150?img=3'),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Hello Joshitha',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Keep Plan For 1 Day',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 120),
              itemCount: sectionsData.length,
              itemBuilder: (context, index) {
                final section = sectionsData[index];
bool expanded = _isExpanded[index] ?? section.initiallyExpanded;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF242443),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            section.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (section.hasAddButton)
                                const Icon(Icons.add_circle_outline,
                                    color: Colors.white),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isExpanded[index] = !expanded;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Icon(
                                    expanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _isExpanded[index] = !expanded;
                            });
                          },
                        ),
                        // Разворачиваемый контент с анимацией
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: expanded && section.subtasks != null
                              ? Column(
                                  key: ValueKey(section.showAllTasks),
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...List.generate(
                                      (section.subtasks!.length > 3 &&
                                              !section.showAllTasks
                                          ? 3
                                          : section.subtasks!.length),
                                      (taskIndex) {
                                        final task =
                                            section.subtasks![taskIndex];
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                task.title,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18),
                                              ),
                                              trailing: Icon(
                                                task.isOpen
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                color: Colors.white70,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  task.isOpen = !task.isOpen;
                                                });
                                              },
                                            ),
                                            AnimatedSize(
                                              duration:
                                                  const Duration(milliseconds: 300),
                                              curve: Curves.easeInOut,
                                              child: task.isOpen
                                                  ? _buildTaskDetails(task)
                                                  : const SizedBox.shrink(),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    if (section.subtasks!.length > 3)
                                      Center(
                                        child: TextButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              section.showAllTasks =
                                                  !section.showAllTasks;
                                            });
                                          },
                                          icon: Icon(
                                            section.showAllTasks
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: Colors.white70,
                                          ),
                                          label: Text(
                                            section.showAllTasks
                                                ? "See Less"
                                                : "See More",
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
           Positioned(
  bottom: 100,
  left: 16,
  right: 16,
  child: SizedBox(
    height: 60,
    child: ElevatedButton.icon(
      onPressed: () {
        // Показываем модальное окно
        showDialog(
          context: context,
          builder: (context) => const CreateTaskDialog(), // <-- наш отдельный класс модалки
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5F33E1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      icon: const Icon(Icons.add_circle_outline,
          color: Colors.white, size: 28),
      label: const Text(
        "Create New Task",
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),
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


