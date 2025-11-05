import 'package:flutter/material.dart';

/// ---------------- MODEL ----------------
class AchievementModel {
  final String title;
  final String contentCount;
  final String duration;
  final Widget iconWidget;

  AchievementModel({
    required this.title,
    required this.contentCount,
    required this.duration,
    required this.iconWidget,
  });
}

/// --------------- ITEM WIDGET ---------------
class AchievementItemWidget extends StatelessWidget {
  final AchievementModel achievement;

  const AchievementItemWidget({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ikon (medali/trofi)
          achievement.iconWidget,

          const SizedBox(width: 16),

          // Informasi Achievement
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.menu_book_rounded,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      achievement.contentCount,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time_rounded,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      achievement.duration,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// --------------- HALAMAN UTAMA ---------------
class AchievementScreen extends StatelessWidget {
  // Data dummy yang meniru desain Ajari
  final List<AchievementModel> achievements = [
    AchievementModel(
      title: 'Completed UI Design\nPart 1 Course',
      contentCount: '26 Content',
      duration: '4h 24min',
      iconWidget: Image.network(
        'https://i.imgur.com/G5Y8u5l.png',
        width: 60,
        height: 60,
      ),
    ),
    AchievementModel(
      title: 'Completed UX Research\nPart 2 Course',
      contentCount: '18 Content',
      duration: '3h 10min',
      iconWidget: Image.network(
        'https://i.imgur.com/vH9Ym1w.png',
        width: 60,
        height: 60,
      ),
    ),
    AchievementModel(
      title: 'Completed Mobile App\nDesign Basics',
      contentCount: '21 Content',
      duration: '5h 00min',
      iconWidget: Image.network(
        'https://i.imgur.com/2s4d4rD.png',
        width: 60,
        height: 60,
      ),
    ),
    AchievementModel(
      title: 'Completed Design Thinking\nWorkshop',
      contentCount: '14 Content',
      duration: '2h 45min',
      iconWidget: Image.network(
        'https://i.imgur.com/eGkH9qX.png',
        width: 60,
        height: 60,
      ),
    ),
  ];

  AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Achievements (${achievements.length})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
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
      ),

      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return AchievementItemWidget(achievement: achievements[index]);
        },
      ),
    );
  }
}