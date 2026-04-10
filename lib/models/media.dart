enum MediaType { episode, clip }

class MediaItem {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final int duration;
  final MediaType type;
  final int? season;
  final int? episode;
  final String releasedAt;
  final List<String> tags;
  final bool isPremium;

  const MediaItem({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.duration,
    required this.type,
    this.season,
    this.episode,
    required this.releasedAt,
    required this.tags,
    required this.isPremium,
  });
}
