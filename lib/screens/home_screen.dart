import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  final List<Product> _fallbackProducts = [
    Product(
      id: 'fallback-1',
      name: 'Voyage Classic Tee',
      description: 'A comfortable classic tee made of 100% premium organic cotton.',
      category: 'T-Shirts',
      price: 2990.0,
      imageUrl: 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=600&fit=crop&q=80',
      rating: 4.2,
      reviewCount: 48,
      sizes: const ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'fallback-2',
      name: 'Voyage Street Hoodie',
      description: 'Warm and soft hoodie with a relaxed fit and heavy fleece lining.',
      category: 'Hoodies',
      price: 4990.0,
      imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=600&fit=crop&q=80',
      rating: 4.5,
      reviewCount: 32,
      sizes: const ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'fallback-3',
      name: 'Voyage Sport Cap',
      description: 'Minimal sport cap with an adjustable brass buckle strap.',
      category: 'Accessories',
      price: 1290.0,
      imageUrl: 'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=600&fit=crop&q=80',
      rating: 4.0,
      reviewCount: 17,
      sizes: const ['One Size'],
    ),
    Product(
      id: 'fallback-4',
      name: 'Voyage Graphic Tee',
      description: 'Eye-catching graphic print tee designed by local artists.',
      category: 'T-Shirts',
      price: 3200.0,
      imageUrl: 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=600&fit=crop&q=80',
      rating: 4.4,
      reviewCount: 29,
      sizes: const ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'fallback-5',
      name: 'Voyage Oversized Tee',
      description: 'Relaxed oversized fit perfect for streetwear styling.',
      category: 'T-Shirts',
      price: 3500.0,
      imageUrl: 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=600&fit=crop&q=80',
      rating: 4.6,
      reviewCount: 14,
      sizes: const ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'fallback-6',
      name: 'Voyage Zip-up Hoodie',
      description: 'Comfortable cotton-poly blend zip hoodie with side pockets.',
      category: 'Hoodies',
      price: 5500.0,
      imageUrl: 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=600&fit=crop&q=80',
      rating: 4.3,
      reviewCount: 22,
      sizes: const ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'fallback-7',
      name: 'Voyage Fleece Sweatshirt',
      description: 'Ultra-soft interior fleece lining to keep you cozy all day long.',
      category: 'Hoodies',
      price: 4800.0,
      imageUrl: 'https://images.unsplash.com/photo-1578587018452-892bacefd3f2?w=600&fit=crop&q=80',
      rating: 4.7,
      reviewCount: 39,
      sizes: const ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'fallback-8',
      name: 'Voyage Wool Beanie',
      description: 'Rib-knit stretch beanie that fits snug and keeps you warm.',
      category: 'Accessories',
      price: 1500.0,
      imageUrl: 'https://images.unsplash.com/photo-1576871337622-98d48d4aa53e?w=600&fit=crop&q=80',
      rating: 4.1,
      reviewCount: 25,
      sizes: const ['One Size'],
    ),
    Product(
      id: 'fallback-9',
      name: 'Voyage Canvas Tote Bag',
      description: 'Durable heavy-duty canvas tote with interior zipped pocket.',
      category: 'Accessories',
      price: 1800.0,
      imageUrl: 'https://images.unsplash.com/photo-1544816155-12df9643f363?w=600&fit=crop&q=80',
      rating: 4.5,
      reviewCount: 11,
      sizes: const ['One Size'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<Product>>(
          stream: ProductService().allProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final hasError = snapshot.hasError;
            final products = snapshot.data ?? [];
            final productList = hasError || products.isEmpty ? _fallbackProducts : products;

            if (hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Unable to load Firestore products. Showing local fallback items.'),
                      duration: const Duration(seconds: 4),
                    ),
                  );
                }
              });
            }

            final categories = <String>{'All'};
            for (final product in productList) {
              categories.add(product.category);
            }
            final categoryList = categories.toList();
            final filteredProducts = _selectedCategory == 'All'
                ? productList
                : productList.where((product) => product.category == _selectedCategory).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Good Morning !',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text('Explore the store', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                          ],
                        ),
                        Stack(
                          children: [
                            const Icon(Icons.notifications_none_rounded, size: 32),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                child: const Text('4', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey.shade500),
                                const SizedBox(width: 12),
                                Text('Search your product', style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                          child: const Icon(Icons.mic, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Categories', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text('View All', style: TextStyle(color: Colors.grey.shade800, fontSize: 14)),
                            const SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade800),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 115,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final category = categoryList[index];
                          final String categoryImage;
                          switch (category) {
                            case 'All':
                              categoryImage = 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=200&h=200&fit=crop&q=80';
                              break;
                            case 'T-Shirts':
                              categoryImage = 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=200&h=200&fit=crop&q=80';
                              break;
                            case 'Hoodies':
                              categoryImage = 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=200&h=200&fit=crop&q=80';
                              break;
                            case 'Accessories':
                              categoryImage = 'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=200&h=200&fit=crop&q=80';
                              break;
                            default:
                              categoryImage = 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=200&h=200&fit=crop&q=80';
                          }
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: _buildCategoryItem(category, categoryImage),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Trending Product', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text('View All', style: TextStyle(color: Colors.grey.shade800, fontSize: 14)),
                            const SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade800),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categoryList.map((category) {
                          final isSelected = category == _selectedCategory;
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                              child: _buildFilterChip(category, isSelected: isSelected),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.65,
                      children: filteredProducts.map((product) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)),
                            );
                          },
                          child: _buildProductCard(product),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String category, String imageUrl) {
    final imagePath = imageUrl.isNotEmpty ? imageUrl : 'assets/images/product_1.png';
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 1.5),
            image: imagePath.startsWith('http')
                ? DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover)
                : DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(category, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: product.imageUrl.startsWith('http')
                ? Image.network(product.imageUrl, width: double.infinity, fit: BoxFit.cover)
                : Image.asset(
                    product.imageUrl.isNotEmpty ? product.imageUrl : 'assets/images/product_1.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text('LKR ${product.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }
}
