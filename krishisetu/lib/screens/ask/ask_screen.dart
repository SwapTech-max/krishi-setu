import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/localization_extensions.dart';
import '../../services/app_state.dart';

class AskScreen extends StatefulWidget {
  const AskScreen({super.key});

  @override
  State<AskScreen> createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
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
            Text(context.loc.askAnExpertTitle),
          ],
        ),
      ),
      body: SafeArea(
        child: Consumer<AppState>(
          builder: (context, state, _) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
              const SizedBox(height: 8),
              Text(
                context.loc.askQuestionHeadline,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 16),
              _buildForm(context),
              const SizedBox(height: 32),
              Text(
                context.loc.recentlyAnswered,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...state.qnaItems.map((item) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    title: Text(item.question),
                    subtitle: Text('${item.askedBy} • ${item.answeredAt.toLocal().toString().split(' ').first}'),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item.answer,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '— ${item.expertName}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 24),
              Card(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: ListTile(
                  leading: const Icon(Icons.chat_bubble_outline),
                  title: Text(context.loc.chatPlaceholderTitle),
                  subtitle: Text(context.loc.chatPlaceholderSubtitle),
                  trailing: FilledButton(
                    onPressed: () {},
                    child: const Text('TODO'),
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

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: context.loc.questionTitleLabel,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.loc.fieldRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: context.loc.questionDescriptionLabel,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return context.loc.fieldRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
              onPressed: () {
                final form = _formKey.currentState;
                if (form != null && form.validate()) {
                  form.save();
                  _titleController.clear();
                  _descriptionController.clear();
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.loc.askSuccessMessage)),
                  );
                  // TODO: Integrate with backend Q&A submission service.
                }
              },
              child: Text(context.loc.submitQuestion),
            ),
          ),
        ],
      ),
    );
  }
}

