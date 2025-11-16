import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/localization_extensions.dart';
import '../../models/content.dart';
import '../../services/app_state.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
            Text(context.loc.learnTitle),
          ],
        ),
      ),
      body: SafeArea(
        child: Consumer<AppState>(
          builder: (context, state, _) {
            final query = _searchController.text.toLowerCase();
            final content = state.learningContent.where((item) {
              if (query.isEmpty) {
                return true;
              }
              return item.title.toLowerCase().contains(query) || item.summary.toLowerCase().contains(query);
            }).toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
              const SizedBox(height: 12),
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: context.loc.learnSearchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              if (content.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(child: Text(context.loc.noContentFound)),
                )
              else
                ...content.map((item) => _LearningCard(content: item)),
            ],
            );
          },
        ),
      ),
    );
  }
}

class _LearningCard extends StatelessWidget {
  const _LearningCard({required this.content});

  final LearningContent content;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to detailed learning content screen.
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                content.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 180,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const Icon(Icons.play_circle_fill, size: 48),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(
                        label: Text(content.type),
                      ),
                      const SizedBox(width: 8),
                      Text(content.duration),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    content.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content.summary,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.loc.discoverMore,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

