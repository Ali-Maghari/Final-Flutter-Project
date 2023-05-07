import 'package:flutter/material.dart';

class MaterialFilledButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const MaterialFilledButton({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
