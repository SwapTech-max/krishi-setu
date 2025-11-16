import 'package:flutter/material.dart';

import '../../core/localization/localization_extensions.dart';
import '../../models/product.dart';

typedef ProductCategoryChanged = void Function(ProductCategory category);
typedef ProductSortChanged = void Function(ProductSort sort);

enum ProductSort { lowToHigh, highToLow, bestRated }

class ProductFilterBar extends StatelessWidget {
  const ProductFilterBar({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.selectedSort,
    required this.onSortChanged,
  });

  final ProductCategory selectedCategory;
  final ProductCategoryChanged onCategoryChanged;
  final ProductSort selectedSort;
  final ProductSortChanged onSortChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.filterByCategory,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ProductCategory.values
              .map(
                (category) => ChoiceChip(
                  label: Text(_labelFor(context, category)),
                  selected: selectedCategory == category,
                  onSelected: (_) => onCategoryChanged(category),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<ProductSort>(
          value: selectedSort,
          decoration: InputDecoration(
            labelText: context.loc.sortBy,
          ),
          items: ProductSort.values
              .map(
                (sort) => DropdownMenuItem(
                  value: sort,
                  child: Text(_sortLabel(context, sort)),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              onSortChanged(value);
            }
          },
        ),
      ],
    );
  }

  String _labelFor(BuildContext context, ProductCategory category) {
    switch (category) {
      case ProductCategory.all:
        return context.loc.categoryAll;
      case ProductCategory.seeds:
        return context.loc.categorySeeds;
      case ProductCategory.fertilizer:
        return context.loc.categoryFertilizer;
      case ProductCategory.pesticide:
        return context.loc.categoryPesticide;
      case ProductCategory.machinery:
        return context.loc.categoryMachinery;
      case ProductCategory.services:
        return context.loc.categoryServices;
    }
  }

  String _sortLabel(BuildContext context, ProductSort sort) {
    switch (sort) {
      case ProductSort.lowToHigh:
        return context.loc.sortLowToHigh;
      case ProductSort.highToLow:
        return context.loc.sortHighToLow;
      case ProductSort.bestRated:
        return context.loc.sortBestRated;
    }
  }
}

