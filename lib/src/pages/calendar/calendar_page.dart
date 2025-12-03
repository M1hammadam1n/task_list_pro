import 'package:flutter/material.dart';
import 'package:maps_test/src/pages/task/create_task_modal.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Логика открытия диалога
    void openCreateTaskDialog() {
      showDialog(
        context: context,
        builder: (context) => const CreateTaskDialog(),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2F),
      body: const SafeArea(child: CalendarPageContent()),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0, left: 16, right: 16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 60,
          child: FloatingActionButton.extended(
            onPressed: openCreateTaskDialog, // Вызов исправленной функции
            backgroundColor: const Color(0xFF5F33E1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
              size: 28,
            ),
            label: const Text(
              "Create New Task",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// --- CalendarPageContent остается без изменений, как в вашем коде ---

class CalendarPageContent extends StatefulWidget {
  // ... (Остальной код)
  // ...
  const CalendarPageContent({super.key});

  @override
  State<CalendarPageContent> createState() => _CalendarPageContentState();
}

class _CalendarPageContentState extends State<CalendarPageContent> {
  final DateTime _today = DateTime.now();
  late DateTime _displayedMonth;
  late DateTime _selectedDate;
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Taitile-1',
      'status': 'incomplete',
      'icon': Icons.sentiment_neutral,
    },
    {
      'title': 'Taitile-2',
      'status': 'complete',
      'icon': Icons.check_circle_outline,
    },
    {
      'title': 'Taitile-3',
      'status': 'incomplete',
      'icon': Icons.sentiment_satisfied,
    },
    {
      'title': 'Taitile-4',
      'status': 'incomplete',
      'icon': Icons.sentiment_satisfied,
    },
    {
      'title': 'Taitile-5',
      'status': 'incomplete',
      'icon': Icons.sentiment_neutral,
    },
    {
      'title': 'Taitile-6',
      'status': 'complete',
      'icon': Icons.check_circle_outline,
    },
    {
      'title': 'Taitile-7',
      'status': 'incomplete',
      'icon': Icons.sentiment_satisfied,
    },
    {
      'title': 'Taitile-8',
      'status': 'incomplete',
      'icon': Icons.sentiment_neutral,
    },
    {
      'title': 'Taitile-9',
      'status': 'complete',
      'icon': Icons.check_circle_outline,
    },
    {
      'title': 'Taitile-10',
      'status': 'incomplete',
      'icon': Icons.sentiment_satisfied,
    },
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _displayedMonth = DateTime(now.year, now.month, 1);
    _selectedDate = now;
  }

  String _getMonthName(int month) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return names[month - 1];
  }

  void _changeMonth(int offset) {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + offset,
        1,
      );
      _selectedDate = _displayedMonth;
    });
  }

  Widget _buildDateCell(DateTime date, bool isCurrentMonth) {
    final isSelected =
        date.day == _selectedDate.day &&
        isCurrentMonth &&
        date.month == _selectedDate.month &&
        date.year == _selectedDate.year;
    final isToday =
        date.day == _today.day &&
        date.month == _today.month &&
        date.year == _today.year;

    final selectedColor = const Color(0xFF673AB7);
    final cellColor = isSelected ? selectedColor : Colors.transparent;
    final textColor = isCurrentMonth ? Colors.white : Colors.white54;

    return InkWell(
      onTap: isCurrentMonth
          ? () {
              setState(() {
                _selectedDate = date;
              });
            }
          : null,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: cellColor,
          shape: BoxShape.circle,
          border: isToday && !isSelected && isCurrentMonth
              ? Border.all(color: Colors.white70, width: 1)
              : null,
        ),
        child: Text(
          date.day.toString(),
          style: TextStyle(color: textColor, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<String> dayNames = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final firstDayOfMonth = _displayedMonth;
    final int startWeekday = firstDayOfMonth.weekday % 7;
    final int daysInPreviousMonth = startWeekday;

    List<DateTime> dateCells = [];
    DateTime date = firstDayOfMonth.subtract(
      Duration(days: daysInPreviousMonth),
    );
    for (int i = 0; i < 42; i++) {
      dateCells.add(date);
      date = date.add(const Duration(days: 1));
    }

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                color: const Color(0xFF1A1A2F),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  _displayedMonth = DateTime(
                                    _today.year,
                                    _today.month,
                                    1,
                                  );
                                  _selectedDate = _today;
                                });
                              },
                            ),
                            Text(
                              '${_displayedMonth.year}  ${_getMonthName(_displayedMonth.month)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () => _changeMonth(-1),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () => _changeMonth(1),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Дни недели
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: dayNames
                          .map(
                            (day) => Text(
                              day,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1.0,
                          ),
                      itemCount: dateCells.length,
                      itemBuilder: (context, index) {
                        final cellDate = dateCells[index];
                        final isCurrentMonth =
                            cellDate.month == _displayedMonth.month;
                        return _buildDateCell(cellDate, isCurrentMonth);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderRow(title: 'Today Tasks', showDropdown: true),
                    const SizedBox(height: 15),
                    ..._tasks.map(_buildTaskItem),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 150,
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF1A1A2F).withOpacity(0.0),
                    const Color(0xFF1A1A2F).withOpacity(0.8),
                    const Color(0xFF1A1A2F).withOpacity(1.0),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderRow({required String title, required bool showDropdown}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> task) {
    final bool isCompleted = task['status'] == 'complete';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF242443),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            task['icon'] as IconData,
            color: isCompleted ? Colors.green : Colors.yellow.shade700,
            size: 24,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              task['title']!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                decorationColor: Colors.white70,
              ),
            ),
          ),
          Icon(
            Icons.check_circle_outline,
            color: isCompleted ? Colors.green : Colors.grey.shade700,
            size: 24,
          ),
          const SizedBox(width: 10),
          const Icon(Icons.add_box_outlined, color: Colors.white70, size: 24),
        ],
      ),
    );
  }
}
