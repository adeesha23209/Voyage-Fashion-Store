import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order.dart';
import '../services/order_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          // Black Header Background
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            color: Colors.black,
          ),
          
          SafeArea(
            child: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, authSnapshot) {
                final user = authSnapshot.data ?? FirebaseAuth.instance.currentUser;
                final displayName = user?.displayName ?? 'Voyage User';
                final email = user?.email ?? 'No email';
                final username = displayName.toLowerCase().replaceAll(' ', '');
                final photoUrl = user?.photoURL;
                
                return Column(
                  children: [
                    // Top Action Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 32),
                              Positioned(
                                right: 2,
                                top: 2,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    '4',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Profile Info Area
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Large VOYAGE background text
                        const Positioned(
                          top: 10,
                          child: Text(
                            'VOYAGE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 64,
                              letterSpacing: 8.0,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                        // Avatar
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade800,
                            backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                                ? NetworkImage(photoUrl)
                                : const NetworkImage('https://images.unsplash.com/photo-1509942774463-acf339cf87d5?w=200&h=200&fit=crop') as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    Text(
                      displayName,
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '@$username',
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      email,
                      style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Scrollable Bottom Sheet Area
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            // 1. Recent Orders Section (if any exist)
                            if (user != null)
                              StreamBuilder<List<Order>>(
                                stream: OrderService().ordersForUser(user.uid),
                                builder: (context, ordersSnapshot) {
                                  final orders = ordersSnapshot.data ?? [];
                                  if (orders.isEmpty) return const SizedBox.shrink();
                                  
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Recent Orders',
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pushNamed(context, '/orders'),
                                              child: const Text('View All', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        height: 120,
                                        child: ListView.separated(
                                          padding: const EdgeInsets.symmetric(horizontal: 24),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: orders.length > 3 ? 3 : orders.length,
                                          separatorBuilder: (_, __) => const SizedBox(width: 16),
                                          itemBuilder: (context, index) {
                                            final order = orders[index];
                                            return GestureDetector(
                                              onTap: () => Navigator.pushNamed(context, '/orders'),
                                              child: Container(
                                                width: 220,
                                                padding: const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.04),
                                                      blurRadius: 10,
                                                      offset: const Offset(0, 5),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Order #${order.id.substring(0, 6)}',
                                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                          decoration: BoxDecoration(
                                                            color: order.status == 'pending' ? Colors.amber.shade50 : Colors.green.shade50,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Text(
                                                            order.status.toUpperCase(),
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              fontWeight: FontWeight.bold,
                                                              color: order.status == 'pending' ? Colors.amber.shade800 : Colors.green.shade800,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'LKR ${order.total.toStringAsFixed(0)}',
                                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                    ),
                                                    Text(
                                                      '${order.items.length} ${order.items.length == 1 ? 'item' : 'items'} • ${order.orderDate.toLocal().toString().split(' ').first}',
                                                      style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                    ],
                                  );
                                },
                              ),
                            
                            // 2. Menu Options Card
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  _buildMenuOption(
                                    Icons.person_outline,
                                    'Your Profile',
                                    isFirst: true,
                                    onTap: () => Navigator.pushNamed(context, '/profile-edit'),
                                  ),
                                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFEEEEEE)),
                                  _buildMenuOption(Icons.location_on_outlined, 'Manage Address'),
                                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFEEEEEE)),
                                  _buildMenuOption(Icons.payment_outlined, 'Payment Method'),
                                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFEEEEEE)),
                                  _buildMenuOption(
                                    Icons.receipt_long_outlined,
                                    'My Orders',
                                    onTap: () => Navigator.pushNamed(context, '/orders'),
                                  ),
                                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFEEEEEE)),
                                  _buildMenuOption(Icons.settings_outlined, 'Settings'),
                                  const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFEEEEEE)),
                                  _buildMenuOption(Icons.logout, 'Logout', isLast: true, onTap: () async {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pushReplacementNamed(context, '/login');
                                  }),
                                ],
                              ),
                            ),
                            
                            // Bottom spacing for bottom nav bar
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, {bool isFirst = false, bool isLast = false, VoidCallback? onTap}) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(icon, color: Colors.grey.shade600, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }
    return content;
  }
}
