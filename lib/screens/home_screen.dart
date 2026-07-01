import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentNavIndex = 0;
  String _selectedTab = 'Stream';
  String _selectedCountry = 'Global';

  final List<String> _tabs = ['Stream', 'Hot', 'Follow'];
  
  final List<Map<String, String>> _countries = [
    {'name': 'Global', 'flag': '🌐'},
    {'name': 'India', 'flag': '🇮🇳'},
    {'name': 'Philippines', 'flag': '🇵🇭'},
    {'name': 'Brazil', 'flag': '🇧🇷'},
    {'name': 'Vietnam', 'flag': '🇻🇳'},
  ];

  final List<Map<String, dynamic>> _streams = [
    {
      'name': 'Sofia Chen',
      'views': '8.2K',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500&auto=format&fit=crop&q=60',
      'flag': '🇵🇭',
      'isFollowing': false,
    },
    {
      'name': 'Isabella Santos',
      'views': '6.4K',
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=500&auto=format&fit=crop&q=60',
      'flag': '🇧🇷',
      'isFollowing': true,
    },
    {
      'name': 'Aarav Patel',
      'views': '12.1K',
      'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&auto=format&fit=crop&q=60',
      'flag': '🇮🇳',
      'isFollowing': false,
    },
    {
      'name': 'Yuki Tanaka',
      'views': '5.8K',
      'image': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=500&auto=format&fit=crop&q=60',
      'flag': '🇻🇳',
      'isFollowing': false,
    },
    {
      'name': 'Emily Johnson',
      'views': '9.5K',
      'image': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&auto=format&fit=crop&q=60',
      'flag': '🇵🇭',
      'isFollowing': false,
    },
    {
      'name': 'Lucas Silva',
      'views': '7.8K',
      'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500&auto=format&fit=crop&q=60',
      'flag': '🇧🇷',
      'isFollowing': false,
    },
    {
      'name': 'Priya Sharma',
      'views': '15.3K',
      'image': 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=500&auto=format&fit=crop&q=60',
      'flag': '🇮🇳',
      'isFollowing': false,
    },
    {
      'name': 'Minh Nguyen',
      'views': '4.2K',
      'image': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500&auto=format&fit=crop&q=60',
      'flag': '🇻🇳',
      'isFollowing': false,
    },
  ];

  void _showProfileMenu(BuildContext context, AuthProvider authProvider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final user = authProvider.user;
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              CircleAvatar(
                radius: 36,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                backgroundColor: AppColors.primary,
                child: user?.photoURL == null
                    ? Text(
                        (user?.displayName ?? user?.email ?? 'D')[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                user?.displayName ?? 'Alive User',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user?.email ?? '',
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    authProvider.signOut(); // Triggers async in the background
                    Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error.withValues(alpha: 0.15),
                    foregroundColor: AppColors.error,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Switch body content based on selected navigation index
            _buildBody(context),
            
            // --- Custom Curved Bottom Navigation Bar ---
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildCurvedNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    switch (_currentNavIndex) {
      case 0:
        return _buildHomeBody(context);
      case 1:
        return const Center(
          child: Text(
            'Party Screen',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        );
      case 2:
        return const Center(
          child: Text(
            'Go Live Screen',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        );
      case 3:
        return const Center(
          child: Text(
            'Chats Screen',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        );
      case 4:
        return const Center(
          child: Text(
            'Profile Screen',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        );
      default:
        return _buildHomeBody(context);
    }
  }

  Widget _buildHomeBody(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- Header Top Bar ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Mini App Logo
              // Mini App Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset('assets/app_icon.png', fit: BoxFit.cover),
                ),
              ),
              
              // Notification & Wallet Group
              Row(
                children: [
                  // Bell Notification with Badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.fieldBackground,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications_none_rounded,
                          color: AppColors.textPrimary,
                          size: 22,
                        ),
                      ),
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Wallet Icon Button (triggers profile sign-out sheet)
                  GestureDetector(
                    onTap: () => _showProfileMenu(context, authProvider),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // --- Tab Bar View Selector ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: _tabs.map((tab) {
              final isSelected = _selectedTab == tab;
              return GestureDetector(
                onTap: () => setState(() => _selectedTab = tab),
                child: Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tab,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? AppColors.primary : AppColors.textSecondary,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 16,
                          height: 3,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        
        // --- Country Selector scroll view ---
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            children: _countries.map((country) {
              final isSelected = _selectedCountry == country['name'];
              return GestureDetector(
                onTap: () => setState(() => _selectedCountry = country['name']!),
                child: Container(
                  margin: const EdgeInsets.only(right: 12.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : AppColors.fieldBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        country['flag']!,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        country['name']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? AppColors.primary : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        
        // --- Streaming Cards Grid ---
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 100.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: _streams.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final stream = _streams[index];
              return _buildStreamCard(stream, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStreamCard(Map<String, dynamic> stream, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Stream Cover Photo
            Image.network(
              stream['image'],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            
            // Vignette dark gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
            
            // View Count Badge
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.remove_red_eye, color: Colors.white, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      stream['views'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Info Row: Name & Follow Button
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        stream['flag'],
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          stream['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  
                  // Follow Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _streams[index]['isFollowing'] = !stream['isFollowing'];
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      decoration: BoxDecoration(
                        color: stream['isFollowing'] ? Colors.white.withValues(alpha: 0.3) : const Color(0xFFFFF200),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        stream['isFollowing'] ? 'Following' : '+ Follow',
                        style: TextStyle(
                          color: stream['isFollowing'] ? Colors.white : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurvedNavigationBar() {
    final size = MediaQuery.of(context).size;
    const barHeight = 85.0;

    return SizedBox(
      height: barHeight + 20, // Add spacing for floating center button
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Curved green bar background
          CustomPaint(
            size: Size(size.width, barHeight),
            painter: CurvedNavigationBarPainter(),
          ),
          
          // Action Buttons
          Container(
            height: barHeight,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_filled, 'Home'),
                _buildNavItem(1, Icons.celebration, 'Party'),
                
                // Gap for central button
                const SizedBox(width: 60),
                
                _buildNavItem(3, Icons.send_rounded, 'Chats'),
                _buildNavItem(4, Icons.person, 'Profile'),
              ],
            ),
          ),
          
          // Central Floating "Go Live" Button
          Positioned(
            top: 5,
            child: GestureDetector(
              onTap: () {
                setState(() => _currentNavIndex = 2);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _currentNavIndex == 2 ? null : Colors.white,
                  gradient: _currentNavIndex == 2 ? AppColors.brandGradient : null,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.sensors, // Wave transmission wave icon matching reference
                    color: _currentNavIndex == 2 ? Colors.white : AppColors.primary,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          
          // "Go Live" Text Label
          Positioned(
            bottom: 4,
            child: GestureDetector(
              onTap: () {
                setState(() => _currentNavIndex = 2);
              },
              child: Text(
                'Go Live',
                style: TextStyle(
                  color: _currentNavIndex == 2 ? Colors.white : Colors.white.withValues(alpha: 0.6),
                  fontSize: 10,
                  fontWeight: _currentNavIndex == 2 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentNavIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentNavIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvedNavigationBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = AppColors.brandGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 20);
    
    // Wave left-to-right curve with a middle dip for the floating button
    final dipWidth = size.width * 0.22;
    final dipStart = (size.width - dipWidth) / 2;
    final dipEnd = dipStart + dipWidth;

    path.lineTo(dipStart, 20);
    
    // Smooth dip curve
    path.cubicTo(
      dipStart + 15,
      20,
      dipStart + 8,
      56,
      size.width / 2,
      56,
    );
    path.cubicTo(
      dipEnd - 8,
      56,
      dipEnd - 15,
      20,
      dipEnd,
      20,
    );
    
    path.lineTo(size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Draw shadow
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.08)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10)
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
