import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_teeth/model/home/day.dart';


class DayWidget extends StatelessWidget {
  final Day day;
  final Function()? onTap;

  const DayWidget({super.key, required this.day, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Card(
          color: day.isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              children: <Widget>[
                Text(
                  DateFormat('MMM').format(day.date),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  day.date.day.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  DateFormat('EEE').format(day.date),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
