import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_app_bar.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final ValueChanged<List<CartItem>> onUpdateCart;

  const CartScreen(
      {super.key, required this.cartItems, required this.onUpdateCart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.cartItems);
  }

  double get _totalPrice =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  int get _totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  void _updateQuantity(int index, int delta) {
    setState(() {
      _items[index].quantity += delta;
      if (_items[index].quantity <= 0) _items.removeAt(index);
    });
    widget.onUpdateCart(_items);
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
    widget.onUpdateCart(_items);
  }

  void _clearCart() {
    setState(() => _items.clear());
    widget.onUpdateCart(_items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: GradientAppBar(
        title: 'My Cart',
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
        actions: _items.isNotEmpty
            ? [
                TextButton(
                  onPressed: _clearCart,
                  child: const Text('Clear all',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                )
              ]
            : null,
      ),
      body: _items.isEmpty ? _buildEmptyCart() : _buildCartList(),
      bottomNavigationBar: _items.isEmpty ? null : _buildCheckoutBar(),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
                gradient: AppColors.softGradient, shape: BoxShape.circle),
            child: Icon(Icons.shopping_bag_outlined,
                size: 50, color: AppColors.gradientMid.withOpacity(0.4)),
          ),
          const SizedBox(height: 22),
          const Text('Your cart is empty',
              style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Add something you love',
              style: TextStyle(color: AppColors.textLight, fontSize: 14)),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              decoration: BoxDecoration(
                  gradient: AppColors.mainGradient,
                  borderRadius: BorderRadius.circular(14)),
              child: const Text('Start Shopping',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return Dismissible(
          key: Key('cart_${item.product.id}'),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => _removeItem(index),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.delete_outline,
                color: Colors.white, size: 28),
          ),
          child: Container(
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
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                      gradient: AppColors.softGradient,
                      borderRadius: BorderRadius.circular(14)),
                  child: Icon(Icons.auto_awesome,
                      color: AppColors.gradientMid.withOpacity(0.45),
                      size: 30),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.product.brand,
                          style: const TextStyle(
                              color: AppColors.textLight,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1)),
                      const SizedBox(height: 3),
                      Text(item.product.name,
                          style: const TextStyle(
                              color: AppColors.textDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${item.totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                                color: AppColors.gradientEnd,
                                fontWeight: FontWeight.w900,
                                fontSize: 16),
                          ),
                          Row(
                            children: [
                              _MiniQtyBtn(
                                  icon: Icons.remove,
                                  onTap: () => _updateQuantity(index, -1)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12),
                                child: Text('${item.quantity}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15,
                                        color: AppColors.textDark)),
                              ),
                              _MiniQtyBtn(
                                  icon: Icons.add,
                                  onTap: () => _updateQuantity(index, 1),
                                  isAdd: true),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, -6))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$_totalItems item${_totalItems == 1 ? '' : 's'}',
                  style: const TextStyle(
                      color: AppColors.textMedium, fontSize: 14)),
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.mainGradient.createShader(bounds),
                child: Text(
                  'Total: \$${_totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text('Order placed!',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                  content: Text(
                      'Your order of \$${_totalPrice.toStringAsFixed(0)} was placed successfully.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _clearCart();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                gradient: AppColors.mainGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: AppColors.gradientMid.withOpacity(0.4),
                      blurRadius: 14,
                      offset: const Offset(0, 5))
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payment, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Text('Checkout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniQtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isAdd;

  const _MiniQtyBtn(
      {required this.icon, required this.onTap, this.isAdd = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          gradient: isAdd ? AppColors.cardGradient : null,
          color: isAdd ? null : AppColors.bgGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon,
            color: isAdd ? Colors.white : AppColors.textMedium, size: 16),
      ),
    );
  }
}
