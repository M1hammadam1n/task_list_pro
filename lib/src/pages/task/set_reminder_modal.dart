import 'package:flutter/material.dart';

class SetReminderDialog extends StatefulWidget {
  final DateTime selectedDate;
  final TimeOfDay? selectedTime;

  const SetReminderDialog({
    super.key,
    required this.selectedDate,
    this.selectedTime,
  });

  @override
  State<SetReminderDialog> createState() => _SetReminderDialogState();
}

class _SetReminderDialogState extends State<SetReminderDialog> {
  String _selectedAmount = '01';
  String _selectedUnit = 'Minutes';

  final List<String> _amounts = ['01', '05', '10', '15', '30', '45', '60'];
  final List<String> _units = ['Minutes', 'Hours', 'Days'];

  String _formatDateTime() {
    final date = widget.selectedDate;
    final time = widget.selectedTime ?? TimeOfDay.now();

    final formattedDate =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    final formattedTime = time.format(context);

    return '$formattedDate $formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    const dialogBackgroundColor = Color(0xFF242443);
    const primaryColor = Color(0xFF673AB7);

    return Dialog(
      backgroundColor: dialogBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Set Reminder',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              _formatDateTime(),
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDropdown(_selectedAmount, _amounts, (newValue) {
                  setState(() {
                    _selectedAmount = newValue!;
                  });
                }),
                const SizedBox(width: 20),
                _buildDropdown(_selectedUnit, _units, (newValue) {
                  setState(() {
                    _selectedUnit = newValue!;
                  });
                }),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton('Cancel', Colors.white30, () {
                  Navigator.of(context).pop();
                }),
                const SizedBox(width: 10),
                _buildActionButton('Done', primaryColor, () {
                  Navigator.of(
                    context,
                  ).pop({'amount': _selectedAmount, 'unit': _selectedUnit});
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: const Color(0xFF242443).withOpacity(0.9),
          style: const TextStyle(color: Colors.white),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onTap) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
