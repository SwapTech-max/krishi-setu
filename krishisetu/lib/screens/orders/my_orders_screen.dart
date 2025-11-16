import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/localization_extensions.dart';
import '../../models/order.dart';
import '../../services/app_state.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const MyOrdersScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  static const String routeName = '/my-orders';

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
            Text(context.loc.myOrders),
          ],
        ),
      ),
      body: SafeArea(
        child: Consumer<AppState>(
          builder: (context, state, _) {
            final orders = state.orders;
            
            if (orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      context.loc.noContentFound,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...orders.map((order) => _OrderCard(order: order)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to order detail screen
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${context.loc.orderNumber} ${order.id}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  _StatusChip(status: order.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${order.products.length} ${order.products.length == 1 ? 'item' : 'items'}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Placed: ${_formatDate(order.placedAt)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    context.loc.currency(order.total),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case OrderStatus.pending:
        backgroundColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange;
        label = 'Pending';
        break;
      case OrderStatus.processing:
        backgroundColor = Colors.blue.withValues(alpha: 0.1);
        textColor = Colors.blue;
        label = 'Processing';
        break;
      case OrderStatus.shipped:
        backgroundColor = Colors.purple.withValues(alpha: 0.1);
        textColor = Colors.purple;
        label = 'Shipped';
        break;
      case OrderStatus.delivered:
        backgroundColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
        label = 'Delivered';
        break;
      case OrderStatus.cancelled:
        backgroundColor = Colors.red.withValues(alpha: 0.1);
        textColor = Colors.red;
        label = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

