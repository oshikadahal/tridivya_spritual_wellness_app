import 'package:flutter/material.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final Color _primary = const Color(0xFF7C4DFF);
  final Color _bg = const Color(0xFFF8F7FD);

  final List<String> _categories = const ['All', 'Yoga', 'Meditation', 'Philosophy'];
  final List<Map<String, dynamic>> _books = const [
    {
      'title': 'Light on Yoga',
      'author': 'B.K.S. Iyengar',
      'tone': Color(0xFFF6D0B1),
      'icon': Icons.self_improvement,
      'image': 'assets/images/light_of_yoga.jpg',
    },
    {
      'title': 'The Power of Now',
      'author': 'Eckhart Tolle',
      'tone': Color(0xFFF4C7AA),
      'icon': Icons.energy_savings_leaf,
      'image': 'assets/images/light_of_yoga.jpg',
    },
    {
      'title': 'Be Here Now',
      'author': 'Ram Dass',
      'tone': Color(0xFFF6D7BA),
      'icon': Icons.spa,
      'image': 'assets/images/light_of_yoga.jpg',
    },
    {
      'title': 'Autobiography of a Yogi',
      'author': 'P. Yogananda',
      'tone': Color(0xFFE9E9F1),
      'icon': Icons.menu_book,
      'image': 'assets/images/light_of_yoga.jpg',
    },
  ];

  final List<Map<String, dynamic>> _learningPaths = const [
    {
      'title': 'Intro to Vedantic Philosophy',
      'resources': '12 resources · curated',
      'colors': [Color(0xFF2F2F3A), Color(0xFF4E4E63)],
      'icon': Icons.school,
    },
    {
      'title': 'Mastering Yoga Nidra',
      'resources': '8 resources · guided',
      'colors': [Color(0xFF4B352F), Color(0xFF6E5146)],
      'icon': Icons.nightlight_round,
    },
  ];

  final List<Map<String, dynamic>> _articles = const [
    {
      'title': 'The Science of 5-Minute Meditation',
      'tag': 'Mindfulness',
      'time': '5 min read',
      'icon': Icons.spa,
    },
    {
      'title': 'Harmonizing Doshas through Diet',
      'tag': 'Ayurveda',
      'time': '8 min read',
      'icon': Icons.restaurant_menu,
    },
  ];

  final List<Map<String, dynamic>> _saved = const [
    {'title': 'Yoga for Beginners', 'icon': Icons.sports_gymnastics},
    {'title': 'The Zen Mind', 'icon': Icons.self_improvement},
    {'title': 'Tranquil Evenings', 'icon': Icons.local_cafe},
  ];

  int _selectedCategory = 0;

  Color get _muted => const Color(0xFF6E6B7B);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(textTheme),
              const SizedBox(height: 18),
              _buildCategories(textTheme),
              const SizedBox(height: 18),
              _buildFeaturedCard(textTheme),
              const SizedBox(height: 24),
              _buildBooks(textTheme),
              const SizedBox(height: 28),
              _buildLearningPaths(textTheme),
              const SizedBox(height: 26),
              _buildArticles(textTheme),
              const SizedBox(height: 26),
              _buildSaved(textTheme),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tridivya',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: _primary,
              ),
            ),
            Text('Library', style: textTheme.bodySmall?.copyWith(color: _muted)),
          ],
        ),
        Row(
          children: [
            _circleButton(icon: Icons.search, onTap: () {}),
            const SizedBox(width: 10),
            _circleButton(icon: Icons.person, onTap: () {}, isAvatar: true),
          ],
        ),
      ],
    );
  }

  Widget _buildCategories(TextTheme textTheme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < _categories.length; i++) ...[
            ChoiceChip(
              label: Text(
                _categories[i],
                style: textTheme.bodyMedium?.copyWith(
                  color: _selectedCategory == i ? Colors.white : _muted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              selected: _selectedCategory == i,
              onSelected: (_) => setState(() => _selectedCategory = i),
              selectedColor: _primary,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(TextTheme textTheme) {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 10),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/light_of_yoga.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.45), Colors.black.withOpacity(0.25)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                'FEATURED BOOK',
                style: textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const Spacer(),
            Text(
              'The Yoga Sutras of Patanjali',
              style: textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ancient wisdom for modern mental mastery.',
              style: textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBooks(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Essential Books',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
            ),
            Text('See All', style: textTheme.bodyMedium?.copyWith(color: _primary, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _books.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) {
            final item = _books[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: SizedBox(
                          height: 140,
                          width: double.infinity,
                          child: item['image'] != null
                              ? Image.asset(
                                  item['image'] as String,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, __) => Container(
                                    color: (item['tone'] as Color).withOpacity(0.95),
                                    child: Center(
                                      child: Icon(
                                        item['icon'] as IconData,
                                        size: 34,
                                        color: Colors.black.withOpacity(0.45),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  color: (item['tone'] as Color).withOpacity(0.95),
                                  child: Center(
                                    child: Icon(
                                      item['icon'] as IconData,
                                      size: 34,
                                      color: Colors.black.withOpacity(0.45),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          height: 26,
                          width: 26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.bookmark_border, size: 18, color: _primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['title'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['author'] as String,
                    style: textTheme.bodySmall?.copyWith(color: _muted),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLearningPaths(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Learning Paths',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _learningPaths.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final path = _learningPaths[index];
              final List<Color> colors = List<Color>.from(path['colors'] as List<Color>);
              return Container(
                width: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/light_of_yoga.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.18),
                        child: Icon(path['icon'] as IconData, color: Colors.white, size: 22),
                      ),
                      const Spacer(),
                      Text(
                        path['title'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        path['resources'] as String,
                        style: textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.85)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildArticles(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Short Reads & Articles',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
            ),
            Text('View List', style: textTheme.bodyMedium?.copyWith(color: _primary, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 14),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _articles.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final article = _articles[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              (article['tag'] as String).toUpperCase(),
                              style: textTheme.labelSmall?.copyWith(color: _primary, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 10),
                            Container(width: 4, height: 4, decoration: BoxDecoration(color: _muted, shape: BoxShape.circle)),
                            const SizedBox(width: 10),
                            Text(article['time'] as String, style: textTheme.bodySmall?.copyWith(color: _muted)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          article['title'] as String,
                          style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    height: 48,
                    width: 60,
                    decoration: BoxDecoration(
                      color: _bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(article['icon'] as IconData, color: _primary),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSaved(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.bookmark, color: Colors.deepPurple),
            const SizedBox(width: 8),
            Text(
              'Saved for Later',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _saved.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = _saved[index];
              return Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/light_of_yoga.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['title'] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        height: 1.05,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap, bool isAvatar = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: isAvatar
              ? Icon(icon, color: Colors.grey.shade700)
              : Icon(icon, color: Colors.grey.shade800),
        ),
      ),
    );
  }
}
