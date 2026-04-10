enum MemberRank { bronze, silver, gold, platinum, diamond }

class User {
  final String id;
  final String email;
  final String displayName;
  final String avatarUrl;
  final MemberRank rank;
  final String joinedAt;
  final String bio;
  final String memberSince;
  final int points;

  const User({
    required this.id,
    required this.email,
    required this.displayName,
    required this.avatarUrl,
    required this.rank,
    required this.joinedAt,
    required this.bio,
    required this.memberSince,
    required this.points,
  });

  User copyWith({
    String? id,
    String? email,
    String? displayName,
    String? avatarUrl,
    MemberRank? rank,
    String? joinedAt,
    String? bio,
    String? memberSince,
    int? points,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rank: rank ?? this.rank,
      joinedAt: joinedAt ?? this.joinedAt,
      bio: bio ?? this.bio,
      memberSince: memberSince ?? this.memberSince,
      points: points ?? this.points,
    );
  }
}
