import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/utils/color_utils.dart';
import '../../models/order.dart';
import '../../models/user.dart';
import '../../services/app_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _cropController;
  late TextEditingController _districtController;

  bool _editing = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AppState>().user;
    _nameController = TextEditingController(text: user.name);
    _phoneController = TextEditingController(text: user.phone);
    _cropController = TextEditingController(text: user.primaryCrop);
    _districtController = TextEditingController(text: user.district);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _cropController.dispose();
    _districtController.dispose();
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
            Text(context.loc.accountTitle),
          ],
        ),
      ),
      body: SafeArea(
        child: Consumer<AppState>(
          builder: (context, state, _) {
            final user = state.user;
            final isHindi = state.locale.languageCode == 'hi';
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
              const SizedBox(height: 16),
              _buildProfileCard(context, user),
              const SizedBox(height: 24),
              Text(
                context.loc.myOrders,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...state.orders.map((order) => _OrderTile(order: order)),
              const SizedBox(height: 24),
              SwitchListTile(
                value: isHindi,
                onChanged: (value) {
                  state.changeLocale(Locale(value ? 'hi' : 'en'));
                },
                title: Text(context.loc.preferredLanguage),
                subtitle: Text(isHindi ? context.loc.languageSwitchHintHi : context.loc.languageSwitchHint),
              ),
              const SizedBox(height: 12),
              FilledButton.tonalIcon(
                onPressed: () {
                  // TODO: Integrate logout logic with authentication service.
                },
                icon: const Icon(Icons.logout),
                label: Text(context.loc.logout),
              ),
            ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, UserProfile user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.loc.profileSectionTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      if (_editing) {
                        final form = _formKey.currentState;
                        if (form != null && form.validate()) {
                          context.read<AppState>().updateUserProfile(
                                user.copyWith(
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  primaryCrop: _cropController.text,
                                  district: _districtController.text,
                                ),
                              );
                          setState(() => _editing = false);
                        }
                      } else {
                        setState(() => _editing = true);
                      }
                    },
                    icon: Icon(_editing ? Icons.check : Icons.edit),
                    label: Text(_editing ? context.loc.saveChanges : context.loc.editProfile),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _ProfileField(
                controller: _nameController,
                label: context.loc.userNameLabel,
                enabled: _editing,
              ),
              const SizedBox(height: 12),
              _ProfileField(
                controller: _phoneController,
                label: context.loc.phoneLabel,
                keyboardType: TextInputType.phone,
                enabled: _editing,
              ),
              const SizedBox(height: 12),
              _ProfileField(
                controller: _cropController,
                label: context.loc.primaryCrop,
                enabled: _editing,
              ),
              const SizedBox(height: 12),
              _ProfileField(
                controller: _districtController,
                label: context.loc.primaryDistrict,
                enabled: _editing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.controller,
    required this.label,
    this.keyboardType,
    this.enabled = false,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? keyboardType;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (value) {
        if (!enabled) {
          return null;
        }
        if (value == null || value.trim().isEmpty) {
          return context.loc.fieldRequired;
        }
        return null;
      },
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withAlphaFraction(0.1),
          child: Icon(Icons.receipt_long, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text('${context.loc.orderNumber} ${order.id}'),
        subtitle: Text(
          '${context.loc.statusLabel}: ${_statusLabel(order.status)} • ${order.products.length} items',
        ),
        trailing: Text(context.loc.currency(order.total)),
        onTap: () {
          // TODO: Implement order detail navigation.
        },
      ),
    );
  }

  String _statusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

