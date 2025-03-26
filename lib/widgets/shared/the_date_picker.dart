import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TheDatePicker extends StatelessWidget {
  const TheDatePicker({
    super.key,
    required this.initialDate,
    required this.onChanged,
    required this.label,
    this.needTime = true,
    this.errorText,
    this.firstDate,
    this.lastDate,
    this.datePattern = "yyyy-MM-dd",
    this.timePattern = "hh:mm a",
  });

  final DateTime? initialDate;
  final Function(DateTime) onChanged;
  final String label;
  final String? errorText;
  final bool needTime;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String datePattern;
  final String timePattern;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat dateFormat = DateFormat(datePattern);
    final DateFormat timeFormat = DateFormat(timePattern);
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_today),
        errorText: errorText,
      ),
      textAlign: initialDate != null ? TextAlign.center : TextAlign.start,
      controller: TextEditingController(
        text: initialDate == null
            ? "Select Date"
            : needTime
                ? "${dateFormat.format(initialDate ?? now)}, ${timeFormat.format(initialDate ?? now)}"
                : dateFormat.format(initialDate ?? now),
      ),
      onTap: () async {
        DateTime? dt = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2000),
          lastDate: lastDate ?? DateTime(2101),
        );
        if (dt != null && context.mounted && needTime) {
          TimeOfDay? tm = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                  hour: initialDate?.hour ?? now.hour,
                  minute: initialDate?.minute ?? now.minute));

          if (tm != null) {
            dt = DateTime(dt.year, dt.month, dt.day, tm.hour, tm.minute);
            onChanged(dt);
          } else {
            dt = DateTime(dt.year, dt.month, dt.day);
            onChanged(dt);
          }
        }
        if (dt != null) {
          onChanged(dt);
        }
      },
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
