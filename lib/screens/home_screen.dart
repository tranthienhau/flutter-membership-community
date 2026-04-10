import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/auth_provider.dart';
import '../providers/media_provider.dart';
import '../providers/feed_provider.dart';
import '../providers/shop_provider.dart';
import '../widgets/video_card.dart';
import '../widgets/event_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-login for demo
    final auth = ref.read(authProvider);
    if (!auth.isAuthenticated) {
      ref.read(authProvider.notifier).login('demo@example.com', 'demo123');
    }
    ref.read(mediaProvider.notifier).fetchMedia();
    ref.read(feedProvider.notifier).fetchFeed();
    ref.read(shopProvider.notifier).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final media = ref.watch(mediaProvider);
    final feed = ref.watch(feedProvider);
    final shop = ref.watch(shopProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: ListView(
          children: [
            // Featured Content
            if (media.featured.isNotEmpty)
              VideoCard(item: media.featured[0], variant: 'featured'),

            // Quick Clips
            if (media.clips.isNotEmpty) ...[
              const SizedBox(height: 28),
              _sectionHeader('Quick Clips', onSeeAll: () {
                // Navigate to media tab handled by shell
              }),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: media.clips.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: VideoCard(
                        item: media.clips[index],
                        variant: 'square',
                      ),
                    );
                  },
                ),
              ),
            ],

            // Upcoming Events
            if (feed.events.isNotEmpty) ...[
              const SizedBox(height: 28),
              _sectionHeader('Upcoming Events'),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: feed.events
                      .take(2)
                      .map((event) => EventCard(
                            event: event,
                            onPress: () =>
                                context.push('/event/${event.id}'),
                          ))
                      .toList(),
                ),
              ),
            ],

            // Limited Drops
            if (shop.drops.isNotEmpty) ...[
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.local_fire_department,
                            size: 18, color: Color(0xFFC8302E)),
                        SizedBox(width: 8),
                        Text(
                          'Limited Drops',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Shop All',
                        style: TextStyle(
                          color: Color(0xFFC8A97E),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: shop.drops.length,
                  itemBuilder: (context, index) {
                    final item = shop.drops[index];
                    return GestureDetector(
                      onTap: () => context.push('/product/${item.id}'),
                      child: Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: item.imageUrl,
                                width: 160,
                                height: 160,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Container(
                                  color: const Color(0xFF1A1A1A),
                                ),
                                errorWidget: (_, __, ___) => Container(
                                  color: const Color(0xFF1A1A1A),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '\$${item.price.toInt()}',
                              style: const TextStyle(
                                color: Color(0xFFC8A97E),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            // Community Banner
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141414),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFC8A97E).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Join the Conversation',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Connect with members, share ideas, and grow together',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward,
                          size: 24, color: Color(0xFFC8A97E)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: const Text(
                'See All',
                style: TextStyle(
                  color: Color(0xFFC8A97E),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
