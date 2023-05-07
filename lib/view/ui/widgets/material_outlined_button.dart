import 'package:flutter/material.dart';

class MaterialOutlinedButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const MaterialOutlinedButton(
      {super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
