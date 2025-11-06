import 'package:flutter/material.dart';

class CourseDetailScreen extends StatefulWidget {
  final String title;
  final String category;
  final String rating;
  final String reviewCount;
  final String joinedCount;
  final String duration;

  const CourseDetailScreen({
    super.key,
    required this.title,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.joinedCount,
    required this.duration,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  int _selectedIndex = 0; // 0: content, 1: reviews, 2: achievement

  // Dummy reviews
  final List<Map<String, String>> _reviews = [
    {
      'username': 'Kevin',
      'avatar': 'https://randomuser.me/api/portraits/men/11.jpg',
      'rating': '5',
      'content': 'Materi sangat jelas dan mudah dipahami.',
    },
    {
      'username': 'Sarah',
      'avatar': 'https://randomuser.me/api/portraits/women/12.jpg',
      'rating': '4',
      'content': 'Praktiknya membantu, tapi butuh lebih banyak contoh.',
    },
  ];

  // Dummy achievements
  final List<Map<String, String>> _achievements = [
    {'title': 'Completed 5 Lessons', 'icon': 'school'},
    {'title': 'Top Performer', 'icon': 'star'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Course header section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1665D8),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          widget.rating,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${widget.reviewCount} reviews)',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Text(
                      '${widget.joinedCount} People Joined',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Tabs: Course Content | Reviews | Achievement
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTabItem('Course Content', 0),
                    _buildTabItem('Reviews', 1),
                    _buildTabItem('Achievement', 2),
                  ],
                ),
                const SizedBox(height: 8),
                // underline indicator
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 3,
                    width: _selectedIndex == 0
                        ? 120
                        : _selectedIndex == 1
                        ? 60
                        : 90,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1665D8),
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildContentArea(),
            ),
          ),

          // Bottom purchase section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  offset: const Offset(0, -4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF1665D8),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.bookmark_border,
                      color: Color(0xFF1665D8),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1665D8),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'PURCHASE (${widget.duration})',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final bool selected = _selectedIndex == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: selected ? Colors.black : Colors.grey,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentArea() {
    if (_selectedIndex == 0) {
      // Course content
      return ListView(
        children: [
          _buildContentItem(
            number: 1,
            title: 'What is SEO?',
            duration: '24min',
          ),
          _buildContentItem(
            number: 2,
            title: 'How SEO Works?',
            duration: '24min',
          ),
          _buildContentItem(
            number: 3,
            title: 'Why learning SEO?',
            duration: '24min',
          ),
          _buildContentItem(
            number: 4,
            title: 'SEO FUNDAMENTAL 1',
            duration: '24min',
          ),
        ],
      );
    } else if (_selectedIndex == 1) {
      // Reviews
      return ListView.separated(
        itemCount: _reviews.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final r = _reviews[index];
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(r['avatar']!)),
            title: Row(
              children: [
                Text(
                  r['username']!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                Icon(Icons.star, color: Colors.orange, size: 14),
                const SizedBox(width: 4),
                Text(r['rating']!),
              ],
            ),
            subtitle: Text(r['content']!),
          );
        },
      );
    } else {
      // Achievement
      return ListView.builder(
        itemCount: _achievements.length,
        itemBuilder: (context, index) {
          final a = _achievements[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(
                a['icon'] == 'star' ? Icons.star : Icons.school,
                color: Colors.amber,
              ),
              title: Text(a['title']!),
              subtitle: const Text('Achievement unlocked'),
            ),
          );
        },
      );
    }
  }

  Widget _buildContentItem({
    required int number,
    required String title,
    required String duration,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF1665D8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '#$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            duration,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.play_circle_fill, color: Color(0xFF1665D8)),
        ],
      ),
    );
  }
}
