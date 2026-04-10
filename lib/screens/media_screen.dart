import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/media_provider.dart';
import '../widgets/video_card.dart';

class MediaScreen extends ConsumerStatefulWidget {
  const MediaScreen({super.key});

  @override
  ConsumerState<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends ConsumerState<MediaScreen> {
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    ref.read(mediaProvider.notifier).fetchMedia();
  }

  @override
  Widget build(BuildContext context) {
    final media = ref.watch(mediaProvider);

    final filteredItems = _filter == 'episodes'
        ? media.episodes
        : _filter == 'clips'
            ? media.clips
            : [...media.episodes, ...media.clips];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Filter tabs
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: ['all', 'episodes', 'clips']
                    .map((type) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _filter = type),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: _filter == type
                                    ? const Color(0xFFC8A97E)
                                    : const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                type[0].toUpperCase() + type.substring(1),
                                style: TextStyle(
                                  color: _filter == type
                                      ? Colors.black
                                      : Colors.white.withValues(alpha: 0.6),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),

            // Featured hero
            if (_filter == 'all' && media.featured.isNotEmpty)
              VideoCard(item: media.featured[0], variant: 'featured'),

            // Clips horizontal
            if (_filter == 'all' && media.clips.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Quick Clips',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
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

            // Episodes list
            if (_filter == 'all')
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Latest Episodes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                itemCount: _filter == 'all'
                    ? media.episodes.length
                    : filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filter == 'all'
                      ? media.episodes[index]
                      : filteredItems[index];
                  return VideoCard(item: item, variant: 'horizontal');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
