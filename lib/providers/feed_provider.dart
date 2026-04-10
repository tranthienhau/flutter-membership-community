import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';
import '../models/event.dart';
import '../models/user.dart';

class FeedState {
  final List<FeedPost> posts;
  final List<Event> events;
  final bool isLoading;

  const FeedState({
    this.posts = const [],
    this.events = const [],
    this.isLoading = false,
  });

  FeedState copyWith({
    List<FeedPost>? posts,
    List<Event>? events,
    bool? isLoading,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final _mockPosts = [
  const FeedPost(
    id: 'post_001',
    author: User(
      id: 'usr_002',
      email: 'sarah@example.com',
      displayName: 'Sarah Chen',
      avatarUrl: 'https://i.pravatar.cc/100?img=5',
      rank: MemberRank.platinum,
      joinedAt: '2023-06-01',
      bio: 'Art curator and community leader',
      memberSince: 'June 2023',
      points: 8900,
    ),
    content:
        'Just attended the private gallery opening in SoHo. The energy was incredible - love connecting with fellow members who appreciate contemporary art. Who else was there?',
    imageUrl: 'https://picsum.photos/seed/post1/600/400',
    createdAt: '2024-11-25T14:30:00Z',
    likes: 47,
    comments: 12,
    isLiked: false,
  ),
  const FeedPost(
    id: 'post_002',
    author: User(
      id: 'usr_003',
      email: 'marcus@example.com',
      displayName: 'Marcus Webb',
      avatarUrl: 'https://i.pravatar.cc/100?img=8',
      rank: MemberRank.diamond,
      joinedAt: '2023-01-15',
      bio: 'Tech entrepreneur and investor',
      memberSince: 'January 2023',
      points: 15200,
    ),
    content:
        'Excited to announce our next members-only dinner series in Miami. Limited to 20 seats. DM me for early access before the official drop.',
    createdAt: '2024-11-24T09:15:00Z',
    likes: 89,
    comments: 34,
    isLiked: true,
  ),
  const FeedPost(
    id: 'post_003',
    author: User(
      id: 'usr_004',
      email: 'nina@example.com',
      displayName: 'Nina Patel',
      avatarUrl: 'https://i.pravatar.cc/100?img=9',
      rank: MemberRank.gold,
      joinedAt: '2024-03-10',
      bio: 'Wellness coach and speaker',
      memberSince: 'March 2024',
      points: 3400,
    ),
    content:
        'Sharing my notes from the wellness retreat last weekend. The breathwork session was transformative. Would love to organize a follow-up session for interested members.',
    imageUrl: 'https://picsum.photos/seed/post3/600/400',
    createdAt: '2024-11-23T18:45:00Z',
    likes: 63,
    comments: 21,
    isLiked: false,
  ),
];

const _mockEvents = [
  Event(
    id: 'evt_001',
    title: 'Members-Only Wine Tasting',
    description:
        'An exclusive evening featuring rare vintages from Napa Valley, paired with artisanal cheeses. Network with fellow connoisseurs in an intimate setting.',
    imageUrl: 'https://picsum.photos/seed/event1/800/450',
    date: '2024-12-15T19:00:00Z',
    location: 'The Vault, Manhattan',
    isVirtual: false,
    capacity: 30,
    attendees: 22,
    price: 150,
    isRsvped: false,
    tags: ['dining', 'networking', 'exclusive'],
  ),
  Event(
    id: 'evt_002',
    title: 'Masterclass: Personal Branding',
    description:
        'Learn from top brand strategists how to build and scale your personal brand in the digital age.',
    imageUrl: 'https://picsum.photos/seed/event2/800/450',
    date: '2024-12-20T11:00:00Z',
    location: 'Virtual',
    isVirtual: true,
    capacity: 200,
    attendees: 156,
    price: 0,
    isRsvped: true,
    tags: ['education', 'branding', 'virtual'],
  ),
  Event(
    id: 'evt_003',
    title: 'New Year Gala 2025',
    description:
        'Ring in the new year at our flagship annual gala. Black tie, live entertainment, and unforgettable memories with the community.',
    imageUrl: 'https://picsum.photos/seed/event3/800/450',
    date: '2024-12-31T20:00:00Z',
    location: 'The Grand Ballroom, Beverly Hills',
    isVirtual: false,
    capacity: 500,
    attendees: 387,
    price: 500,
    isRsvped: false,
    tags: ['gala', 'celebration', 'premium'],
  ),
];

const mockComments = [
  Comment(
    id: 'cmt_001',
    author: User(
      id: 'usr_005',
      email: 'david@example.com',
      displayName: 'David Kim',
      avatarUrl: 'https://i.pravatar.cc/100?img=15',
      rank: MemberRank.silver,
      joinedAt: '2024-06-01',
      bio: 'Photographer',
      memberSince: 'June 2024',
      points: 1200,
    ),
    content: 'This was amazing! Definitely want to join the next one.',
    createdAt: '2024-11-25T15:00:00Z',
    likes: 5,
  ),
  Comment(
    id: 'cmt_002',
    author: User(
      id: 'usr_006',
      email: 'lily@example.com',
      displayName: 'Lily Thompson',
      avatarUrl: 'https://i.pravatar.cc/100?img=20',
      rank: MemberRank.gold,
      joinedAt: '2024-02-15',
      bio: 'Interior designer',
      memberSince: 'February 2024',
      points: 3800,
    ),
    content: 'Count me in for the follow-up session!',
    createdAt: '2024-11-25T15:30:00Z',
    likes: 3,
  ),
];

class FeedNotifier extends StateNotifier<FeedState> {
  FeedNotifier() : super(const FeedState());

  Future<void> fetchFeed() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500));
    state = FeedState(
      posts: List.from(_mockPosts),
      events: _mockEvents,
      isLoading: false,
    );
  }

  void toggleLike(String postId) {
    state = state.copyWith(
      posts: state.posts.map((post) {
        if (post.id == postId) {
          return post.copyWith(
            isLiked: !post.isLiked,
            likes: post.isLiked ? post.likes - 1 : post.likes + 1,
          );
        }
        return post;
      }).toList(),
    );
  }

  void addPost(String content) {
    final newPost = FeedPost(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      author: const User(
        id: 'usr_001',
        email: 'member@community.app',
        displayName: 'Alex Morgan',
        avatarUrl: 'https://i.pravatar.cc/200?img=12',
        rank: MemberRank.gold,
        joinedAt: '2024-01-15',
        bio: '',
        memberSince: 'January 2024',
        points: 4250,
      ),
      content: content,
      createdAt: DateTime.now().toIso8601String(),
      likes: 0,
      comments: 0,
      isLiked: false,
    );
    state = state.copyWith(posts: [newPost, ...state.posts]);
  }
}

final feedProvider =
    StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  return FeedNotifier();
});
