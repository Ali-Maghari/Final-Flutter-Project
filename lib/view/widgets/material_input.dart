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
  final String? Function(String? value)? validator;
  final AutovalidateMode? autoValidateMode = AutovalidateMode.onUserInteraction;
  final void Function()? onTap;

  const MaterialInput(this.label,
      {super.key,
      this.errorText,
      this.isObscureText = false,
      this.prefixIcon,
      this.suffixIcon,
      this.isEnabled = true,
      this.isReadOnly = false,
      this.controller,
      this.validator,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      readOnly: isReadOnly,
      autovalidateMode: autoValidateMode,
      validator: validator,
      controller: controller,
      onTap: onTap,
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
