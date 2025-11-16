import 'package:flutter/material.dart';

import 'product.dart';

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}

@immutable
class Order {
  const Order({
    required this.id,
    required this.products,
    required this.placedAt,
    required this.status,
    required this.total,
  });

  final String id;
  final List<Product> products;
  final DateTime placedAt;
  final OrderStatus status;
  final double total;
}

