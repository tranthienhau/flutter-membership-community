import 'user.dart';

class FeedPost {
  final String id;
  final User author;
  final String content;
  final String? imageUrl;
  final String createdAt;
  final int likes;
  final int comments;
  final bool isLiked;

  const FeedPost({
    required this.id,
    required this.author,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    required this.likes,
    required this.comments,
    required this.isLiked,
  });

  FeedPost copyWith({
    String? id,
    User? author,
    String? content,
    String? imageUrl,
    String? createdAt,
    int? likes,
    int? comments,
    bool? isLiked,
  }) {
    return FeedPost(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}

class Comment {
  final String id;
  final User author;
  final String content;
  final String createdAt;
  final int likes;

  const Comment({
    required this.id,
    required this.author,
    required this.content,
    required this.createdAt,
    required this.likes,
  });
}
