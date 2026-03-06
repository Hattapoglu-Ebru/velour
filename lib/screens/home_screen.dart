import 'package:flutter/material.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> _allProducts = getProductsFromJson();

  String _selectedCategory = 'All';
  String _searchQuery = '';
  final List<int> _favoriteIds = [];
  final List<CartItem> _cartItems = [];
  final TextEditingController _searchController = TextEditingController();

  List<Product> get _filteredProducts {
    return _allProducts.where((p) {
      final matchesCategory =
          _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.tags.any(
              (t) => t.toLowerCase().contains(_searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
  }

  int get _cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  void _addToCart(Product product) {
    setState(() {
      final existing = _cartItems.where((i) => i.product.id == product.id);
      if (existing.isNotEmpty) {
        existing.first.quantity++;
      } else {
        _cartItems.add(CartItem(product: product));
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text('${product.name} added to cart',
                  style: const TextStyle(fontSize: 13)),
            ),
          ],
        ),
        backgroundColor: AppColors.gradientMid,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleFavorite(int productId) {
    setState(() {
      if (_favoriteIds.contains(productId)) {
        _favoriteIds.remove(productId);
      } else {
        _favoriteIds.add(productId);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredProducts;
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.gradientStart,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration:
                    const BoxDecoration(gradient: AppColors.mainGradient),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'VELOUR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 4,
                                  ),
                                ),
                                Text(
                                  'Discover your beauty',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                _HeaderIconButton(
                                  icon: Icons.favorite_border,
                                  badge: _favoriteIds.length,
                                  onTap: () {
                                    final favProducts = _allProducts
                                        .where((p) =>
                                            _favoriteIds.contains(p.id))
                                        .toList();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FavoritesScreen(
                                          favoriteProducts: favProducts,
                                          favoriteIds: _favoriteIds,
                                          onFavoriteToggle: _toggleFavorite,
                                          onAddToCart: _addToCart,
                                          cartItems: _cartItems,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                _HeaderIconButton(
                                  icon: Icons.shopping_bag_outlined,
                                  badge: _cartItemCount,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CartScreen(
                                        cartItems: _cartItems,
                                        onUpdateCart: (updated) => setState(
                                            () => _cartItems
                                              ..clear()
                                              ..addAll(updated)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.35)),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (val) =>
                                setState(() => _searchQuery = val),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Search products, brands or tags...',
                              hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.65),
                                  fontSize: 13),
                              prefixIcon: Icon(Icons.search,
                                  color: Colors.white.withOpacity(0.8),
                                  size: 20),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        _searchController.clear();
                                        setState(() => _searchQuery = '');
                                      },
                                      child: Icon(Icons.close,
                                          color: Colors.white.withOpacity(0.8),
                                          size: 18),
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            title: const Text(
              'VELOUR',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: 3),
            ),
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined,
                        color: Colors.white),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartScreen(
                          cartItems: _cartItems,
                          onUpdateCart: (updated) => setState(() =>
                              _cartItems..clear()..addAll(updated)),
                        ),
                      ),
                    ),
                  ),
                  if (_cartItemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Center(
                          child: Text('$_cartItemCount',
                              style: const TextStyle(
                                  color: AppColors.gradientEnd,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          SliverPersistentHeader(
            pinned: true,
            delegate: _CategoryHeaderDelegate(
              categories: categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: (cat) =>
                  setState(() => _selectedCategory = cat),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.mainGradient.createShader(bounds),
                child: Text(
                  '${filtered.length} product${filtered.length == 1 ? '' : 's'} found',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
              ),
            ),
          ),

          filtered.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded,
                            size: 64,
                            color: AppColors.textLight.withOpacity(0.5)),
                        const SizedBox(height: 16),
                        const Text('No products found',
                            style: TextStyle(
                                color: AppColors.textMedium,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        const Text('Try a different search or category',
                            style: TextStyle(
                                color: AppColors.textLight, fontSize: 13)),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = filtered[index];
                        return ProductCard(
                          product: product,
                          isFavorite: _favoriteIds.contains(product.id),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: {
                                'product': product,
                                'isFavorite':
                                    _favoriteIds.contains(product.id),
                                'cartItems': _cartItems,
                              },
                            ).then((result) {
                              if (result != null && result is Map) {
                                setState(() {
                                  if (result['toggleFavorite'] == true) {
                                    _toggleFavorite(product.id);
                                  }
                                  if (result['addToCart'] == true) {
                                    _addToCart(product);
                                  }
                                });
                              }
                            });
                          },
                          onFavoriteToggle: () => _toggleFavorite(product.id),
                          onAddToCart: () => _addToCart(product),
                        );
                      },
                      childCount: filtered.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final int badge;
  final VoidCallback onTap;

  const _HeaderIconButton(
      {required this.icon, required this.badge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          if (badge > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 17,
                height: 17,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Center(
                  child: Text('$badge',
                      style: const TextStyle(
                          color: AppColors.gradientEnd,
                          fontSize: 9,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<String> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  _CategoryHeaderDelegate(
      {required this.categories,
      required this.selectedCategory,
      required this.onCategorySelected});

  @override
  double get minExtent => 56;
  @override
  double get maxExtent => 56;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.bgLight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: categories.length,
        itemBuilder: (_, index) {
          final cat = categories[index];
          return CategoryChip(
            label: cat,
            isSelected: cat == selectedCategory,
            onTap: () => onCategorySelected(cat),
          );
        },
      ),
    );
  }

  @override
  bool shouldRebuild(_CategoryHeaderDelegate old) =>
      old.selectedCategory != selectedCategory;
}
