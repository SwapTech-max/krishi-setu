import 'package:flutter/material.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/utils/color_utils.dart';

class FpoConnectScreen extends StatelessWidget {
  const FpoConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.quickActionFpo),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.loc.quickActionFpo,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover Farmer Producer Organisations (FPOs), cooperatives, and agri-startups partnered with KrishiSetu. '
                    'Collaborate for bulk procurement, aggregation, extension services, and market linkages.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _FpoTile(
            name: 'Betla FPO Collective',
            members: '1200+ farmers',
            focus: 'Pulse aggregation, agro-input retail, custom hiring centre',
          ),
          _FpoTile(
            name: 'Ramgarh Organic Federation',
            members: '700+ farmers',
            focus: 'Organic vegetable clusters, cold chain, direct-to-market',
          ),
          _FpoTile(
            name: 'Koyal Agro Producers Ltd.',
            members: '2000+ farmers',
            focus: 'Seed production, soil testing, mechanisation services',
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Become a Partner',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Are you an FPO, cooperative, or agri-service organisation? Partner with KrishiSetu to offer '
                    'quality inputs, advisory, and market access to farmers.',
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Partnership form coming soon.')),
                      );
                    },
                    child: const Text('Express Interest'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FpoTile extends StatelessWidget {
  const _FpoTile({
    required this.name,
    required this.members,
    required this.focus,
  });

  final String name;
  final String members;
  final String focus;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withAlphaFraction(0.12),
          child: Icon(Icons.groups, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(members),
            const SizedBox(height: 4),
            Text(
              focus,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Detailed profile for $name coming soon.')),
          );
        },
      ),
    );
  }
}

