import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/localization/localization_extensions.dart';
import '../services/app_state.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, state, _) {
        final cartCount = state.cart.length;
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onSelected,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_filled),
              label: context.loc.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.storefront),
              label: context.loc.buy,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.chat_bubble_outline),
              label: context.loc.ask,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.school_outlined),
              label: context.loc.learn,
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.person_outline),
                  if (cartCount > 0)
                    Positioned(
                      right: -6,
                      top: -4,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Theme.of(context).colorScheme.error,
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              label: context.loc.account,
            ),
          ],
        );
      },
    );
  }
}

