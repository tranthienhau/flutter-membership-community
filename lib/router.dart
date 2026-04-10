import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/media_screen.dart';
import 'screens/community_screen.dart';
import 'screens/shop_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/product_detail_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/auth/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/post/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          PostDetailScreen(postId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/event/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          EventDetailScreen(eventId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/product/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) =>
          ProductDetailScreen(productId: state.pathParameters['id']!),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => _ShellScreen(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/media',
          builder: (context, state) => const MediaScreen(),
        ),
        GoRoute(
          path: '/community',
          builder: (context, state) => const CommunityScreen(),
        ),
        GoRoute(
          path: '/shop',
          builder: (context, state) => const ShopScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);

class _ShellScreen extends StatelessWidget {
  final Widget child;

  const _ShellScreen({required this.child});

  static const _tabs = [
    ('/', Icons.home_outlined, Icons.home, 'Home'),
    ('/media', Icons.play_circle_outline, Icons.play_circle, 'Media'),
    ('/community', Icons.people_outline, Icons.people, 'Community'),
    ('/shop', Icons.shopping_bag_outlined, Icons.shopping_bag, 'Shop'),
    ('/profile', Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final currentIndex = _tabs.indexWhere((tab) => tab.$1 == location);
    final selectedIndex = currentIndex >= 0 ? currentIndex : 0;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabs.length, (index) {
                final tab = _tabs[index];
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => context.go(tab.$1),
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(
                    width: 64,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? tab.$3 : tab.$2,
                          size: 24,
                          color: isSelected
                              ? const Color(0xFFC8A97E)
                              : Colors.white.withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          tab.$4,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFFC8A97E)
                                : Colors.white.withValues(alpha: 0.4),
                            fontSize: 10,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
