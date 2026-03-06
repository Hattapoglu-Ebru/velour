import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product product;
  late bool isFavorite;
  late List<CartItem> cartItems;
  bool _initialized = false;
  int _quantity = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      // Receiving data via Route Arguments
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      product = args['product'] as Product;
      isFavorite = args['isFavorite'] as bool;
      cartItems = args['cartItems'] as List<CartItem>;
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppColors.gradientStart,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => setState(() => isFavorite = !isFavorite),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.pink[100] : Colors.white,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(width: 4),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration:
                    const BoxDecoration(gradient: AppColors.mainGradient),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white.withOpacity(0.4), width: 2),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            product.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) => Icon(
                              _getCategoryIcon(product.category),
                              size: 72,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (product.isNew)
                            _Badge(label: 'New', color: AppColors.badgeNew),
                          if (product.isBestseller)
                            _Badge(
                                label: 'Bestseller',
                                color: AppColors.badgeBestseller),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(22, 26, 22, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.brand,
                      style: const TextStyle(
                        color: AppColors.textLight,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (i) {
                            return Icon(
                              i < product.rating.floor()
                                  ? Icons.star_rounded
                                  : (i < product.rating
                                      ? Icons.star_half_rounded
                                      : Icons.star_outline_rounded),
                              color: AppColors.accentGold,
                              size: 20,
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          product.rating.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                              fontSize: 15),
                        ),
                        Text(
                          '  (${product.reviewCount} reviews)',
                          style: const TextStyle(
                              color: AppColors.textLight, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: AppColors.softGradient,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color:
                                    AppColors.gradientMid.withOpacity(0.2)),
                          ),
                          child: Text(
                            tag,
                            style: const TextStyle(
                                color: AppColors.gradientEnd,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'About this product',
                      style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 17,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.description,
                      style: const TextStyle(
                          color: AppColors.textMedium,
                          fontSize: 14,
                          height: 1.7),
                    ),
                    const SizedBox(height: 28),

                    const Text(
                      'Quantity',
                      style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 17,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _QuantityButton(
                          icon: Icons.remove,
                          onTap: () {
                            if (_quantity > 1) setState(() => _quantity--);
                          },
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '$_quantity',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textDark),
                          ),
                        ),
                        _QuantityButton(
                          icon: Icons.add,
                          onTap: () => setState(() => _quantity++),
                          isAdd: true,
                        ),
                        const Spacer(),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppColors.mainGradient.createShader(bounds),
                          child: Text(
                            '\$${(product.price * _quantity).toStringAsFixed(0)}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, -6))
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => isFavorite = !isFavorite),
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                    color: AppColors.bgGrey,
                    borderRadius: BorderRadius.circular(16)),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color:
                      isFavorite ? AppColors.accentPink : AppColors.textMedium,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, {
                    'addToCart': true,
                    'toggleFavorite': false,
                    'quantity': _quantity,
                  });
                },
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: AppColors.mainGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.gradientMid.withOpacity(0.4),
                          blurRadius: 16,
                          offset: const Offset(0, 6))
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined,
                          color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Add to Cart',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5),
                      ),
                    ],
                  ),
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

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isAdd;

  const _QuantityButton(
      {required this.icon, required this.onTap, this.isAdd = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: isAdd ? AppColors.cardGradient : null,
          color: isAdd ? null : AppColors.bgGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon,
            color: isAdd ? Colors.white : AppColors.textMedium, size: 20),
      ),
    );
  }
}