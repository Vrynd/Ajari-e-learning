import 'package:flutter/material.dart';

class ColorSkinsScreen extends StatefulWidget {
  const ColorSkinsScreen({super.key});

  @override
  State<ColorSkinsScreen> createState() => _ColorSkinsScreenState();
}

class _ColorSkinsScreenState extends State<ColorSkinsScreen> {
  String _layout = 'Light';
  Color _selectedColor = const Color(0xFF1976D2); // Blue default

  final Map<String, Color> _colors = {
    'Red': const Color(0xFFD32F2F),
    'Green': const Color(0xFF388E3C),
    'Blue': const Color(0xFF1976D2),
    'Pink': const Color(0xFFD81B60),
    'Yellow': const Color(0xFFFBC02D),
    'Orange': const Color(0xFFF57C00),
    'Purple': const Color(0xFF7B1FA2),
    'Deeppurple': const Color(0xFF512DA8),
    'Lightblue': const Color(0xFF03A9F4),
    'Teal': const Color(0xFF00796B),
    'Lime': const Color(0xFFCDDC39),
    'Deeporange': const Color(0xFFF4511E),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Color Themes',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0, top: 14.0),
            child: Text('Link', style: TextStyle(color: Colors.grey[600])),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              const Text(
                'Color Themes',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 18),

              // Layout Themes
              const Text(
                'Layout Themes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1665D8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F8FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Framework7 comes with 2 main layout themes: Light (default) and Dark:',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _layoutTile('Light', isDark: false),
                        const SizedBox(width: 12),
                        _layoutTile('Dark', isDark: true),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),
              const Text(
                'Default Color Themes',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1665D8),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F8FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Framework7 comes with 12 color themes set.'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _colors.entries
                          .map((e) => _colorTile(e.key, e.value))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _layoutTile(String label, {required bool isDark}) {
    final bool selected = _layout == label;
    return GestureDetector(
      onTap: () => setState(() => _layout = label),
      child: Container(
        width: 120,
        height: 56,
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF1665D8) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: isDark
                  ? const SizedBox.shrink()
                  : const Icon(Icons.check_box, color: Color(0xFF1665D8)),
            ),
            if (selected)
              const Positioned(
                right: 6,
                top: 6,
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFF1665D8),
                  size: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _colorTile(String name, Color color) {
    final bool selected = _selectedColor.value == color.value;
    final textColor = color.computeLuminance() > 0.6
        ? Colors.black
        : Colors.white;
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        width: 90,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: selected
              ? Border.all(color: Colors.black.withOpacity(0.2), width: 3)
              : null,
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                name,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
              ),
            ),
            if (selected)
              const Positioned(
                right: 6,
                top: 6,
                child: Icon(Icons.check_circle, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }
}
