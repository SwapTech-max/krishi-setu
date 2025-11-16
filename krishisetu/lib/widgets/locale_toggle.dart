import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/utils/color_utils.dart';
import '../services/app_state.dart';

class LocaleToggle extends StatelessWidget {
  const LocaleToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        final isHindi = state.locale.languageCode == 'hi';
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlphaFraction(0.15),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LocaleChip(
                label: 'EN',
                selected: !isHindi,
                onTap: () => state.changeLocale(const Locale('en')),
              ),
              const SizedBox(width: 4),
              _LocaleChip(
                label: 'हिंदी',
                selected: isHindi,
                onTap: () => state.changeLocale(const Locale('hi')),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LocaleChip extends StatelessWidget {
  const _LocaleChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: selected ? Theme.of(context).colorScheme.primary : Colors.white,
          ),
        ),
      ),
    );
  }
}

