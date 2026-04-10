import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class AuthState {
  final User? user;
  final bool isAuthenticated;
  final bool isLoading;

  const AuthState({
    this.user,
    this.isAuthenticated = false,
    this.isLoading = false,
  });

  AuthState copyWith({
    User? user,
    bool? isAuthenticated,
    bool? isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

const _mockUser = User(
  id: 'usr_001',
  email: 'member@community.app',
  displayName: 'Alex Morgan',
  avatarUrl: 'https://i.pravatar.cc/200?img=12',
  rank: MemberRank.gold,
  joinedAt: '2024-01-15',
  bio:
      'Creative director and community enthusiast. Passionate about design, culture, and connecting with like-minded people.',
  memberSince: 'January 2024',
  points: 4250,
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 1200));
    state = AuthState(
      user: _mockUser,
      isAuthenticated: true,
      isLoading: false,
    );
  }

  void logout() {
    state = const AuthState();
  }

  void updateProfile(User updated) {
    state = state.copyWith(user: updated);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
