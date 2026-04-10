import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/media.dart';

class MediaState {
  final List<MediaItem> featured;
  final List<MediaItem> episodes;
  final List<MediaItem> clips;
  final bool isLoading;

  const MediaState({
    this.featured = const [],
    this.episodes = const [],
    this.clips = const [],
    this.isLoading = false,
  });

  MediaState copyWith({
    List<MediaItem>? featured,
    List<MediaItem>? episodes,
    List<MediaItem>? clips,
    bool? isLoading,
  }) {
    return MediaState(
      featured: featured ?? this.featured,
      episodes: episodes ?? this.episodes,
      clips: clips ?? this.clips,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

const _mockEpisodes = [
  MediaItem(
    id: 'med_001',
    title: 'The Art of Connection',
    description:
        'Explore how elite communities build meaningful relationships that transcend typical networking.',
    thumbnailUrl: 'https://picsum.photos/seed/ep1/800/450',
    videoUrl: 'https://example.com/video1.mp4',
    duration: 2820,
    type: MediaType.episode,
    season: 1,
    episode: 1,
    releasedAt: '2024-11-01',
    tags: ['culture', 'networking', 'lifestyle'],
    isPremium: false,
  ),
  MediaItem(
    id: 'med_002',
    title: 'Design Thinking for Life',
    description:
        'Award-winning designers share how creative thinking transforms everyday decisions.',
    thumbnailUrl: 'https://picsum.photos/seed/ep2/800/450',
    videoUrl: 'https://example.com/video2.mp4',
    duration: 3240,
    type: MediaType.episode,
    season: 1,
    episode: 2,
    releasedAt: '2024-11-08',
    tags: ['design', 'creativity', 'mindset'],
    isPremium: true,
  ),
  MediaItem(
    id: 'med_003',
    title: 'Behind the Brand',
    description:
        'Go behind the scenes with founders building the next generation of luxury brands.',
    thumbnailUrl: 'https://picsum.photos/seed/ep3/800/450',
    videoUrl: 'https://example.com/video3.mp4',
    duration: 2460,
    type: MediaType.episode,
    season: 1,
    episode: 3,
    releasedAt: '2024-11-15',
    tags: ['business', 'luxury', 'entrepreneurship'],
    isPremium: true,
  ),
];

const _mockClips = [
  MediaItem(
    id: 'clip_001',
    title: 'Quick Take: Morning Rituals',
    description: 'Top members share their morning routines.',
    thumbnailUrl: 'https://picsum.photos/seed/clip1/400/400',
    videoUrl: 'https://example.com/clip1.mp4',
    duration: 90,
    type: MediaType.clip,
    releasedAt: '2024-11-20',
    tags: ['lifestyle', 'wellness'],
    isPremium: false,
  ),
  MediaItem(
    id: 'clip_002',
    title: 'Style Spotlight: Winter Essentials',
    description: 'Curated picks from our fashion community.',
    thumbnailUrl: 'https://picsum.photos/seed/clip2/400/400',
    videoUrl: 'https://example.com/clip2.mp4',
    duration: 60,
    type: MediaType.clip,
    releasedAt: '2024-11-22',
    tags: ['fashion', 'style'],
    isPremium: false,
  ),
];

class MediaNotifier extends StateNotifier<MediaState> {
  MediaNotifier() : super(const MediaState());

  Future<void> fetchMedia() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 600));
    state = MediaState(
      featured: [_mockEpisodes[0]],
      episodes: _mockEpisodes,
      clips: _mockClips,
      isLoading: false,
    );
  }
}

final mediaProvider =
    StateNotifierProvider<MediaNotifier, MediaState>((ref) {
  return MediaNotifier();
});
