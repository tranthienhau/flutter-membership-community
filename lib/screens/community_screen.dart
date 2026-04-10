import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/feed_provider.dart';
import '../widgets/feed_post.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  final _postController = TextEditingController();
  bool _showComposer = false;

  @override
  void initState() {
    super.initState();
    ref.read(feedProvider.notifier).fetchFeed();
  }

  void _handlePost() {
    if (_postController.text.trim().isNotEmpty) {
      ref.read(feedProvider.notifier).addPost(_postController.text.trim());
      _postController.clear();
      setState(() => _showComposer = false);
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = ref.watch(feedProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Composer
            if (_showComposer)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF141414),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFC8A97E)),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _postController,
                      autofocus: true,
                      maxLines: null,
                      minLines: 3,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Share something with the community...',
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() => _showComposer = false);
                            _postController.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: _handlePost,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC8A97E),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Post',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else
              GestureDetector(
                onTap: () => setState(() => _showComposer = true),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141414),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined,
                          size: 18,
                          color: Colors.white.withValues(alpha: 0.4)),
                      const SizedBox(width: 10),
                      Text(
                        'Share something with the community...',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Feed
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 100),
                itemCount: feed.posts.length,
                itemBuilder: (context, index) {
                  final post = feed.posts[index];
                  return FeedPostWidget(
                    post: post,
                    onLike: () =>
                        ref.read(feedProvider.notifier).toggleLike(post.id),
                    onPress: () => context.push('/post/${post.id}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
