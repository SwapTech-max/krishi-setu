import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/localization_extensions.dart';
import '../../core/utils/color_utils.dart';
import '../../models/product.dart';
import '../../services/app_state.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  static Route route(Product product) {
    return MaterialPageRoute(
      builder: (_) => ProductDetailScreen(product: product),
      settings: const RouteSettings(name: routeName),
    );
  }

  static const String routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final images = product.imageUrls;
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
            Expanded(
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: PageView.builder(
                itemCount: images.isEmpty ? 1 : images.length,
                itemBuilder: (context, index) {
                  final image = images.isEmpty ? null : images[index];
                  if (image == null) return const _ImageFallback();
                  final isLocalImage = image.startsWith('assets/');
                  return isLocalImage
                      ? Image.asset(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const _ImageFallback(),
                        )
                      : Image.network(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const _ImageFallback(),
                        );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            product.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber.shade600),
              const SizedBox(width: 4),
              Text('${product.rating.toStringAsFixed(1)} ${context.loc.ratingLabel}'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            context.loc.currency(product.price),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            context.loc.productDescription,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            product.longDescription,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Text(
            context.loc.reviews,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          ..._mockReviews.map(
            (review) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary.withAlphaFraction(0.08),
                  child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
                ),
                title: Text(review['name']!),
                subtitle: Text(review['comment']!),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<AppState>(
            builder: (context, state, _) {
              return FilledButton(
                onPressed: () {
                  state.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.loc.addToCartSuccess)),
                  );
                },
                child: Text('${context.loc.addToCart} • ${context.loc.currency(product.price)}'),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  const _ImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Center(
        child: Icon(Icons.agriculture, size: 48),
      ),
    );
  }
}

const List<Map<String, String>> _mockReviews = [
  {
    'name': 'Arjun Sahu',
    'comment': 'Great quality seeds, germination was above 90%.',
  },
  {
    'name': 'Anita Devi',
    'comment': 'Packaging was excellent and delivery was on time.',
  },
];

