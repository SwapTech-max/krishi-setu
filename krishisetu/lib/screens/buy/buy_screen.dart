import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/localization_extensions.dart';
import '../../models/product.dart';
import '../../services/app_state.dart';
import '../../widgets/product/product_card.dart';
import '../../widgets/product/product_filter_bar.dart';
import 'product_detail_screen.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});
  @override
  State<BuyScreen> createState() => _BuyScreenState();
}
class _BuyScreenState extends State<BuyScreen> {
  ProductCategory _selectedCategory = ProductCategory.all;
  ProductSort _selectedSort = ProductSort.lowToHigh;
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
            Text(context.loc.buyScreenTitle),
          ],
        ),
      ),
      body: SafeArea(
        child: Consumer<AppState>(
          builder: (context, state, _) {
            // Defensive check: ensure state is initialized
            if (state.products.isEmpty) {
              return Center(
                child: Text(
                  context.loc.noContentFound,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }
            
            final products = _applyFilters(state.products);
            return LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 1000
                  ? 4
                  : constraints.maxWidth > 720
                      ? 3
                      : 2;
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ProductFilterBar(
                        selectedCategory: _selectedCategory,
                        onCategoryChanged: (category) {
                          setState(() => _selectedCategory = category);
                        },
                        selectedSort: _selectedSort,
                        onSortChanged: (sort) {
                          setState(() => _selectedSort = sort);
                        },
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    sliver: products.isEmpty
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                              child: Center(
                                child: Text(
                                  context.loc.noContentFound,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          )
                        : SliverGrid(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.75,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                // defensive: ensure index in range
                                if (index < 0 || index >= products.length) return const SizedBox.shrink();
                                final product = products[index];
                                return ProductCard(
                                  product: product,
                                  onViewDetails: () {
                                    try {
                                      Navigator.of(context).push(
                                        ProductDetailScreen.route(product),
                                      );
                                    } catch (e, st) {
                                      // Defensive: show a friendly message instead of crashing
                                      debugPrint('Navigation error: $e\n$st');
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(context.loc.somethingWentWrong)),
                                        );
                                      }
                                    }
                                  },
                                );
                              },
                              childCount: products.length,
                            ),
                    ),
                  ),
                ],
              );
            },
          );
          },
        ),
      ),
    );
  }

  List<Product> _applyFilters(List<Product> products) {
    // make a defensive copy
    final List<Product> filtered = List<Product>.from(products);
    if (_selectedCategory != ProductCategory.all) {
      filtered.retainWhere((p) => p.category == _selectedCategory);
    }
    // Sorting
    try {
      filtered.sort((a, b) {
        switch (_selectedSort) {
          case ProductSort.lowToHigh:
            return a.price.compareTo(b.price);
          case ProductSort.highToLow:
            return b.price.compareTo(a.price);
          case ProductSort.bestRated:
            return b.rating.compareTo(a.rating);
        }
      });
    } catch (e) {
      // If sorting fails for any reason, keep original order and log
      debugPrint('Product sort error: $e');
    }
    return filtered;
  }
}
