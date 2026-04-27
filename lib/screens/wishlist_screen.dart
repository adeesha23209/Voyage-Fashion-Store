import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Wishlist',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildWishlistItem(
                  'assets/images/product_1.png',
                  'Classic Oversize Tee',
                  'LKR 3,850',
                  'LKR 1,283.33',
                ),
                _buildWishlistItem(
                  'assets/images/product_2.png',
                  'Women Crop Top',
                  'LKR 2,990',
                  'LKR 996.66',
                ),
                _buildWishlistItem(
                  'assets/images/product_3.png',
                  'Signature Hoodie',
                  'LKR 5,990',
                  'LKR 1,996.66',
                ),
                _buildWishlistItem(
                  'assets/images/product_4.png',
                  'Casual Shoes',
                  'LKR 3,850',
                  'LKR 1,283.33',
                ),
                _buildWishlistItem(
                  'assets/images/product_5.png',
                  'New York Black Cap',
                  'LKR 3,000',
                  'LKR 1,000',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(String imageUrl, String title, String price, String installment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: 100,
              height: 110,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                    const Icon(Icons.favorite, color: Colors.black, size: 20),
                  ],
                ),
                const SizedBox(height: 4),
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  'or with 3 installments of $installment',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // Mintpay placeholder
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A1F35),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'mintpay',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // KOKO placeholder
                    const Text(
                      'KOKO',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                        shadows: [Shadow(color: Colors.blueAccent, offset: Offset(1, 1))],
                      ),
                    ),
                    const Spacer(),
                    // Add to Cart Button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
