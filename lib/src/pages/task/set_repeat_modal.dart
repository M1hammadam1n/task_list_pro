import 'package:flutter/material.dart';

enum RepeatInterval {
  minutes,
  hours,
  daily,
  weekly,
  monthly,
  yearly,
  none, // Добавим "None" для "No Repeat"
}

class SetRepeatDialog extends StatefulWidget {
  final RepeatInterval initialRepeatInterval;

  const SetRepeatDialog({
    super.key,
    this.initialRepeatInterval = RepeatInterval.none,
  });

  @override
  State<SetRepeatDialog> createState() => _SetRepeatDialogState();
}

class _SetRepeatDialogState extends State<SetRepeatDialog> {
  late RepeatInterval _selectedInterval;

  @override
  void initState() {
    super.initState();
    _selectedInterval = widget.initialRepeatInterval;
  }

  String _getIntervalName(RepeatInterval interval) {
    switch (interval) {
      case RepeatInterval.minutes:
        return 'Minutes';
      case RepeatInterval.hours:
        return 'Hours';
      case RepeatInterval.daily:
        return 'Daily';
      case RepeatInterval.weekly:
        return 'Weekly';
      case RepeatInterval.monthly:
        return 'Monthly';
      case RepeatInterval.yearly:
        return 'Yearly';
      case RepeatInterval.none:
        return 'No Repeat';
    }
  }

  Widget _buildRepeatOption(RepeatInterval interval, String title) {
    return RadioListTile<RepeatInterval>(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      value: interval,
      groupValue: _selectedInterval,
      onChanged: (RepeatInterval? value) {
        setState(() {
          _selectedInterval = value!;
        });
      },
      activeColor: const Color(0xFF673AB7),
      fillColor: WidgetStateProperty.resolveWith<Color>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF673AB7);
        }
        return Colors.white70;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<RepeatInterval> displayIntervals = [
      RepeatInterval.minutes,
      RepeatInterval.hours,
      RepeatInterval.daily,
      RepeatInterval.weekly,
      RepeatInterval.monthly,
      RepeatInterval.yearly,
    ];

    return Dialog(
      backgroundColor: const Color(0xFF242443),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Text(
                'Set as Repeat Task',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...displayIntervals.map((interval) {
              return _buildRepeatOption(interval, _getIntervalName(interval));
            }).toList(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(null);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(_selectedInterval);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF673AB7),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
