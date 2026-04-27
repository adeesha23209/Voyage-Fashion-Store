import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          // Black Header Background
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            color: Colors.black,
          ),
          
          SafeArea(
            child: Column(
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
                          fontFamily: 'Times New Roman', // using serif to match design
                        ),
                      ),
                    ),
                    // Avatar
                    Container(
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.all(4), // For a slight border effect if needed
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1509942774463-acf339cf87d5?w=200&h=200&fit=crop'), // Model hoodie image
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                const Text(
                  'Adeesha Lakshan',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '@adeeshavoyage',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                ),
                
                const SizedBox(height: 30),
                
                // Menu Card
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          _buildMenuOption(Icons.person_outline, 'Your Profile', isFirst: true),
                          const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFEEEEEE)),
                          _buildMenuOption(Icons.location_on_outlined, 'Manage Address'),
                          const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFEEEEEE)),
                          _buildMenuOption(Icons.payment_outlined, 'Payment Method'),
                          const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFEEEEEE)),
                          _buildMenuOption(Icons.receipt_long_outlined, 'My Orders'),
                          const Divider(height: 1, indent: 20, endIndent: 20, color: Color(0xFFEEEEEE)),
                          _buildMenuOption(Icons.settings_outlined, 'Settings', isLast: true),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Bottom spacing for bottom nav bar
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption(IconData icon, String title, {bool isFirst = false, bool isLast = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey.shade600, size: 24),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
