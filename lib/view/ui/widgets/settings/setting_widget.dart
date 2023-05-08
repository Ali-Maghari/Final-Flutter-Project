import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  final String title;
  final Icon? icon;
  final Function()? onTap;

  const SettingWidget({super.key, required this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: Theme.of(context).colorScheme.secondaryContainer,
          onTap: () {
            onTap?.call();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                  ),
                ),
                icon ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
