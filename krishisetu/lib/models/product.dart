import 'package:flutter/material.dart';

enum ProductCategory {
  all,
  seeds,
  fertilizer,
  pesticide,
  machinery,
  services,
}

@immutable
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.category,
    required this.price,
    required this.rating,
    required this.imageUrls,
    required this.tags,
  });

  final String id;
  final String name;
  final String shortDescription;
  final String longDescription;
  final ProductCategory category;
  final double price;
  final double rating;
  final List<String> imageUrls;
  final List<String> tags;

  Product copyWith({
    String? id,
    String? name,
    String? shortDescription,
    String? longDescription,
    ProductCategory? category,
    double? price,
    double? rating,
    List<String>? imageUrls,
    List<String>? tags,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageUrls: imageUrls ?? this.imageUrls,
      tags: tags ?? this.tags,
    );
  }
}

