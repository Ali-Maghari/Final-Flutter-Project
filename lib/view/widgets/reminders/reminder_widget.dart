import 'package:flutter/material.dart';

class Reminder extends StatelessWidget {
  final Function()? onPressed;

  const Reminder({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.favorite_border),
      label: const Text('Save'),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      onPressed: () {

      },
    );
  }
}