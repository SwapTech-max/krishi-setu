import 'package:flutter/material.dart';

import '../core/localization/localization_extensions.dart';

class VoiceSearchButton extends StatelessWidget {
  const VoiceSearchButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        onTap?.call();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.loc.voiceSearchComingSoon)),
        );
      },
      icon: const Icon(Icons.mic),
      label: Text(context.loc.voiceSearchTooltip),
    );
  }
}

