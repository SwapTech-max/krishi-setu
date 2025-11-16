import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/localization/localization_extensions.dart';
import '../../models/product.dart';
import '../../services/app_state.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onViewDetails,
  });

  final Product product;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final image = product.imageUrls.isNotEmpty ? product.imageUrls.first : null;
    final isLocalImage = image != null && image.startsWith('assets/');
    
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onViewDetails,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: image != null
                  ? isLocalImage
                      ? Image.asset(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => _ImagePlaceholder(name: product.name),
                        )
                      : Image.network(
                          image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stack) => _ImagePlaceholder(name: product.name),
                        )
                  : _ImagePlaceholder(name: product.name),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontSize: 13,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber.shade600, size: 14),
                        const SizedBox(width: 2),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.loc.currency(product.price),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Consumer<AppState>(
                      builder: (context, state, _) {
                        return Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  minimumSize: const Size(0, 36),
                                ),
                                onPressed: () {
                                  state.addToCart(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(context.loc.addToCartSuccess)),
                                  );
                                },
                                child: Text(
                                  context.loc.addToCart,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                minimumSize: const Size(36, 36),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              tooltip: context.loc.viewDetails,
                              onPressed: onViewDetails,
                              icon: const Icon(Icons.open_in_new, size: 18),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Text(
          name[0].toUpperCase(),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}

