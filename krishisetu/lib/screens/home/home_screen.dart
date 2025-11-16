import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/utils/color_utils.dart';
import '../../services/app_state.dart';
import '../../widgets/section_header.dart';
import '../ask/ask_screen.dart';
import '../buy/buy_screen.dart';
import '../fpo/fpo_connect_screen.dart';
import '../orders/my_orders_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/logo.jpg',
                height: 40,
                width: 40,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            const SizedBox(width: 12),
            Text(context.loc.appTitle),
          ],
        ),
      ),
      body: SafeArea(
        child: Consumer<AppState>(
          builder: (context, state, _) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _WelcomeStoryBlock(),
                      const SizedBox(height: 24),
                      _SearchAndActionsRow(
                        onSearchTap: () {},
                        onMicTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(context.loc.voiceSearchComingSoon)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _QuickActionsGrid(),
                      const SizedBox(height: 32),
                      SectionHeader(
                        title: context.loc.aiRecommendationTitle,
                        actionText: context.loc.discoverMore,
                        onActionTap: () {},
                      ),
                      Text(
                        context.loc.recommendationSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        title: context.loc.homePartnersTitle,
                        actionText: context.loc.seeAll,
                        onActionTap: () {},
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 120,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.partners.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final partner = state.partners[index];
                            return _PartnerCard(
                              name: partner['name'] as String,
                              farmers: partner['farmers'] as int,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
          },
        ),
      ),
    );
  }
}

class _WelcomeStoryBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 680;
        return Container(
          padding: EdgeInsets.all(isWide ? 24 : 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.loc.homeWelcomeTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      context.loc.homeWelcomeSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.loc.homeIntroTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.loc.homeIntroBody,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              if (isWide) ...[
                const SizedBox(width: 24),
                _StoryStats(),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _StoryStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Theme.of(context).colorScheme.primary.withAlphaFraction(0.18),
          child: Icon(
            Icons.handshake,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '5k+',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          context.loc.farmersConnected,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SearchAndActionsRow extends StatelessWidget {
  const _SearchAndActionsRow({
    required this.onSearchTap,
    required this.onMicTap,
  });

  final VoidCallback onSearchTap;
  final VoidCallback onMicTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.loc.searchInputsHint,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: context.loc.searchInputsHint,
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onTap: onSearchTap,
                  readOnly: true,
                ),
              ),
              const SizedBox(width: 12),
              FloatingActionButton.small(
                heroTag: 'voice-home',
                onPressed: onMicTap,
                child: const Icon(Icons.mic),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class _QuickActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cards = [
      _QuickAction(
        icon: Icons.storefront,
        label: context.loc.quickActionStore,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const BuyScreen()),
        ),
      ),
      _QuickAction(
        icon: Icons.chat_bubble_outline,
        label: context.loc.quickActionExpert,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AskScreen()),
        ),
      ),
      _QuickAction(
        icon: Icons.receipt_long,
        label: context.loc.quickActionOrders,
        onTap: () => Navigator.of(context).push(
          MyOrdersScreen.route(),
        ),
      ),
      _QuickAction(
        icon: Icons.groups_2,
        label: context.loc.quickActionFpo,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const FpoConnectScreen()),
        ),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 680;
        final double spacing = 16;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.spaceBetween,
          children: cards
              .map(
                (card) => SizedBox(
                  width: isWide ? (constraints.maxWidth - spacing) / 2 : double.infinity,
                  child: card,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                offset: const Offset(0, 6),
                color: scheme.primary.withAlphaFraction(0.08),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      scheme.primary.withAlphaFraction(0.18),
                      scheme.secondary.withAlphaFraction(0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: scheme.primary, size: 26),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: scheme.primary.withAlphaFraction(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.chevron_right, color: scheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PartnerCard extends StatelessWidget {
  const _PartnerCard({
    required this.name,
    required this.farmers,
  });

  final String name;
  final int farmers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 8),
            color: Colors.black.withAlphaFraction(0.08),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary.withAlphaFraction(0.12),
            child: Icon(Icons.groups, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '$farmers+ ${context.loc.farmersConnected}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
