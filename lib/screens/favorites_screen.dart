import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Product> favoriteProducts;
  final List<int> favoriteIds;
  final ValueChanged<int> onFavoriteToggle;
  final ValueChanged<Product> onAddToCart;
  final List<CartItem> cartItems;

  const FavoritesScreen({
    super.key,
    required this.favoriteProducts,
    required this.favoriteIds,
    required this.onFavoriteToggle,
    required this.onAddToCart,
    required this.cartItems,
  });

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<Product> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = List.from(widget.favoriteProducts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: GradientAppBar(
        title: 'Wishlist',
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ),
      body: _favorites.isEmpty ? _buildEmpty() : _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        final product = _favorites[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: AppColors.gradientMid.withOpacity(0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    gradient: AppColors.softGradient,
                    borderRadius: BorderRadius.circular(14)),
                child: Icon(Icons.favorite,
                    color: AppColors.accentPink.withOpacity(0.4), size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.brand,
                        style: const TextStyle(
                            color: AppColors.textLight,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1)),
                    const SizedBox(height: 3),
                    Text(product.name,
                        style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                                color: AppColors.gradientEnd,
                                fontWeight: FontWeight.w900,
                                fontSize: 16)),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.onAddToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${product.name} added to cart'),
                                    backgroundColor: AppColors.gradientMid,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 7),
                                decoration: BoxDecoration(
                                    gradient: AppColors.cardGradient,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Row(
                                  children: [
                                    Icon(Icons.add_shopping_cart,
                                        color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text('Add',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                widget.onFavoriteToggle(product.id);
                                setState(() => _favorites
                                    .removeWhere((p) => p.id == product.id));
                              },
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(Icons.favorite,
                                    color: Colors.red.shade300, size: 17),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
                gradient: AppColors.softGradient, shape: BoxShape.circle),
            child: Icon(Icons.favorite_border,
                size: 48, color: AppColors.accentPink.withOpacity(0.45)),
          ),
          const SizedBox(height: 22),
          const Text('No favorites yet',
              style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Tap the heart icon on any product to save it here',
              style: TextStyle(color: AppColors.textLight, fontSize: 13),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
