import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.gradientMid.withOpacity(0.10),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ürün görseli & badge & favori
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  // Product image container
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.softGradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        product.imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stack) => Center(
                          child: Icon(
                            _getCategoryIcon(product.category),
                            size: 42,
                            color: AppColors.gradientMid.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Badge — NEW or BESTSELLER
                  if (product.isNew || product.isBestseller)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: product.isNew
                              ? AppColors.badgeNew
                              : AppColors.badgeBestseller,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          product.isNew ? 'New' : 'Bestseller',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // Favori butonu
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFavorite
                              ? AppColors.accentPink
                              : AppColors.textLight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Ürün bilgileri
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brand,
                          style: const TextStyle(
                            color: AppColors.textLight,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),

                    // Puan
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 13,
                          color: AppColors.accentGold,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          product.rating.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textMedium,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ' (${product.reviewCount})',
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),

                    // Price and cart button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: AppColors.gradientEnd,
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        GestureDetector(
                          onTap: onAddToCart,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              gradient: AppColors.cardGradient,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
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

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Fragrance':
        return Icons.water_drop_outlined;
      case 'Lips':
        return Icons.face_retouching_natural;
      case 'Eyes':
        return Icons.visibility_outlined;
      case 'Skincare':
        return Icons.spa_outlined;
      case 'Base':
        return Icons.brush_outlined;
      case 'Cheeks':
        return Icons.auto_awesome_outlined;
      default:
        return Icons.star_outline;
    }
  }
}