import 'package:flutter/material.dart';

class MaterialTextButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const MaterialTextButton({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
