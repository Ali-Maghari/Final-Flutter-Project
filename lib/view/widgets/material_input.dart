import 'package:flutter/material.dart';

class MaterialInput extends StatelessWidget {
  final Widget label;
  final String? errorText;
  final bool isObscureText;
  final Widget? prefixIcon;
  final Widget? Function(bool isObscureText)? suffixIcon;
  final bool isEnabled;
  final bool isReadOnly;
  final TextEditingController? controller;

  const MaterialInput(this.label,
      {super.key,
      this.errorText,
      this.isObscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.isEnabled = true,
      this.isReadOnly = false,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscureText,
      readOnly: isReadOnly,
      controller: controller,
      decoration: InputDecoration(
          isDense: true,
          enabled: isEnabled,
          label: label,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon != null ? suffixIcon!(isObscureText) : null,
          errorText: errorText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(600),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary))),
    );
  }
}
