import 'package:flutter/material.dart';

/// Model data untuk komentar
class CommentModel {
  final String username;
  final String content;
  final String avatarUrl;
  final int likes;
  final int replies;

  CommentModel({
    required this.username,
    required this.content,
    required this.avatarUrl,
    this.likes = 0,
    this.replies = 0,
  });
}

/// Widget untuk menampilkan satu komentar
class CommentItemWidget extends StatelessWidget {
  final CommentModel comment;
  final bool showActions;

  const CommentItemWidget({
    super.key,
    required this.comment,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade300,
            backgroundImage:
                comment.avatarUrl.isNotEmpty ? NetworkImage(comment.avatarUrl) : null,
            child: comment.avatarUrl.isEmpty
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 12),

          // Konten komentar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),

                // Aksi Like dan Reply (jika ada)
                if (showActions) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.thumb_up_alt_outlined,
                          size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '${comment.likes}',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.comment_outlined,
                          size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '${comment.replies} replies',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Halaman utama diskusi
class DiscussionScreen extends StatelessWidget {
  // Data dummy untuk tampilan
  final List<CommentModel> comments = [
    CommentModel(
      username: 'Kevin Sirait',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
      avatarUrl: '',
      likes: 45,
      replies: 4,
    ),
    CommentModel(
      username: 'Thomas Jono',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod',
      avatarUrl: '',
      likes: 45,
      replies: 4,
    ),
    CommentModel(
      username: 'Cinthya Moss',
      content: 'Lorem ipsum dolor sit amet, consectetur',
      avatarUrl: '',
    ),
    CommentModel(
      username: 'Romeo Silalahi',
      content: 'Lorem ipsum dolor sit amet, consectetur',
      avatarUrl: '',
    ),
    CommentModel(
      username: 'Paula Jean',
      content: 'Lorem ipsum dolor sit amet, consectetur',
      avatarUrl: '',
    ),
  ];

  DiscussionScreen({super.key});

  /// Widget untuk tombol "Add Review" di bawah
  Widget _buildAddReviewBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur add review coming soon!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text(
              'ADD REVIEW',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar mirip header desain
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Discussions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Text(
              'Latest',
              style: TextStyle(color: Colors.blue),
            ),
            label: const Icon(Icons.arrow_drop_down, color: Colors.blue),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),

      // Body utama
      body: Stack(
        children: [
          // Daftar komentar
          ListView.builder(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 80),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              final bool hasActions =
                  comment.likes > 0 || comment.replies > 0;
              return CommentItemWidget(
                comment: comment,
                showActions: hasActions,
              );
            },
          ),

          // Tombol tambah review di bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildAddReviewBox(context),
          ),
        ],
      ),
    );
  }
}