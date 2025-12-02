  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
import 'package:maps_test/src/pages/task/set_reminder_modal.dart';

  class SetDateTime extends StatefulWidget {
    const SetDateTime({super.key});

    @override
    State<SetDateTime> createState() => _SelectSetDialogState();
  }

  class _SelectSetDialogState extends State<SetDateTime> {
    final DateTime _today = DateTime.now();
    late DateTime _displayedMonth;
    late DateTime _selectedDate;
    TimeOfDay? _selectedTime;

    @override
    void initState() {
      super.initState();
      final now = DateTime.now();
      _displayedMonth = DateTime(now.year, now.month, 1);
      _selectedDate = now;
      _selectedTime = TimeOfDay.now();
    }

    String _getMonthName(int month) {
      const names = [
        'January', 'February', 'March', 'April', 'May', 'June', 'July',
        'August', 'September', 'October', 'November', 'December'
      ];
      return names[month - 1];
    }

    void _changeMonth(int offset) {
      setState(() {
        _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + offset, 1);
        if (_selectedDate.year != _displayedMonth.year || _selectedDate.month != _displayedMonth.month) {
          _selectedDate = _displayedMonth;
        }
      });
    }

    Widget _buildDateCell(DateTime date, bool isCurrentMonth) {
      final isSelected = date.day == _selectedDate.day && isCurrentMonth && date.month == _selectedDate.month;
      final isToday = date.day == _today.day && date.month == _today.month && date.year == _today.year;
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
            border: isToday && !isSelected && isCurrentMonth ? Border.all(color: Colors.white70, width: 1) : null,
          ),
          child: Text(
            date.day.toString(),
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ),
      );
    }

    Widget _buildControlRow({
      required IconData icon,
      required String title,
      required String value,
      required VoidCallback onTap,
    }) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  value,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      );
    }
  Future<void> _selectTime(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        Duration initialDuration = Duration(
          hours: _selectedTime?.hour ?? 0,
          minutes: _selectedTime?.minute ?? 0,
        );
        return Container(
          height: 250,
          decoration: BoxDecoration(
            color: const Color(0xFF242443),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      pickerTextStyle: TextStyle(
                        color: Colors.white, // цвет цифр
                        fontSize: 22,
                      ),
                    ),
                  ),
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    initialTimerDuration: initialDuration,
                    minuteInterval: 1,
                    onTimerDurationChanged: (duration) {
                      setState(() {
                        _selectedTime = TimeOfDay(
                          hour: duration.inHours,
                          minute: duration.inMinutes % 60,
                        );
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


    @override
    Widget build(BuildContext context) {
      const List<String> dayNames = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
      final firstDayOfMonth = _displayedMonth;
      final int startWeekday = firstDayOfMonth.weekday % 7;
      final int daysInPreviousMonth = startWeekday;
      final DateTime nextMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 1);
      final int daysInCurrentMonth = nextMonth.difference(firstDayOfMonth).inDays;

      List<DateTime> dateCells = [];
      DateTime date = firstDayOfMonth.subtract(Duration(days: daysInPreviousMonth));
      for (int i = 0; i < daysInPreviousMonth; i++) {
        dateCells.add(date);
        date = date.add(const Duration(days: 1));
      }
      for (int i = 0; i < daysInCurrentMonth; i++) {
        dateCells.add(date);
        date = date.add(const Duration(days: 1));
      }
      final remainingCells = 42 - dateCells.length;
      for (int i = 0; i < remainingCells; i++) {
        dateCells.add(date);
        date = date.add(const Duration(days: 1));
      }
void _openReminderDialog() {
  showDialog(
    context: context,
    builder: (ctx) {
      return SetReminderDialog(
        selectedDate: _selectedDate,      // Обязательно передаём выбранную дату
        selectedTime: _selectedTime,      // Передаём выбранное время, если нужно
      );
    },
  ).then((result) {
    // Обработка результата после закрытия SetReminderDialog
    if (result != null) {
      setState(() {
        // Например, обновляем текст в UI для строки Reminder
        // result = {'amount': '10', 'unit': 'Minutes'} или что-то подобное
      });
    }
  });
}


      return Dialog(
        backgroundColor: const Color(0xFF242443),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Calendar Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayedMonth.year.toString(),
                          style: const TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                        Text(
                          _getMonthName(_displayedMonth.month),
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                          onPressed: () => _changeMonth(-1),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                          onPressed: () => _changeMonth(1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Days of week
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: dayNames
                      .map((day) => Text(
                            day,
                            style: const TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.bold),
                          ))
                      .toList(),
                ),
              ),
              // Date Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: dateCells.length,
                  itemBuilder: (context, index) {
                    final date = dateCells[index];
                    final isCurrentMonth = date.month == _displayedMonth.month;
                    return _buildDateCell(date, isCurrentMonth);
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Time Row
              _buildControlRow(
                icon: Icons.access_time,
                title: 'Time',
                value: _selectedTime?.format(context) ?? '--:--',
                onTap: () => _selectTime(context),
              ),
              const Divider(color: Colors.white12, height: 0, indent: 20, endIndent: 20),
              // Reminder Row
          _buildControlRow(
  icon: Icons.notifications_none,
  title: 'Reminder',
  value: 'No', // В рабочем приложении здесь будет отображаться статус напоминания
  // При нажатии вызываем функцию, которая закроет текущий диалог с инструкцией
  onTap: _openReminderDialog,
),
const Divider(color: Colors.white12, height: 0, indent: 20, endIndent: 20),
              const Divider(color: Colors.white12, height: 0, indent: 20, endIndent: 20),
              // Repeat Row
              _buildControlRow(
                icon: Icons.repeat,
                title: 'Repeat',
                value: 'No Repeat',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      print('Selected Date: $_selectedDate, Time: $_selectedTime');
                      Navigator.of(context).pop({'date': _selectedDate, 'time': _selectedTime});
                    },
                    child: const Text('Done', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
