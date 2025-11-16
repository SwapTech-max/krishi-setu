import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (actionText != null && onActionTap != null)
          TextButton(
            onPressed: onActionTap,
            child: Text(actionText!),
          ),
      ],
    );
  }
}

