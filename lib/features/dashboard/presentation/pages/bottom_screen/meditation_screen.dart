import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/profile_page.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/meditation_detail_page.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  Color get _primary => const Color(0xFF7C4DFF);
  Color get _muted => const Color(0xFF6E6B7B);
  Color get _cardBg => const Color(0xFFF6F5FB);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              const SizedBox(height: 18),
              _buildFilterPills(textTheme),
              const SizedBox(height: 16),
              _buildSectionTitle('Featured Selection', textTheme),
              const SizedBox(height: 10),
              _buildFeaturedCard(context, textTheme),
              const SizedBox(height: 20),
              _buildSectionTitle('Recently Added', textTheme, trailing: 'See All'),
              const SizedBox(height: 12),
              _buildRecentList(textTheme),
              const SizedBox(height: 22),
              _buildSectionTitle('Our Instructors', textTheme),
              const SizedBox(height: 12),
              _buildInstructors(),
              const SizedBox(height: 22),
              _buildSectionTitle('Meditation Series', textTheme),
              const SizedBox(height: 12),
              _buildSeriesCards(textTheme),
              const SizedBox(height: 24),
              _buildQuickCalm(textTheme),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tridivya',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
            ),
            Text('Meditation Library', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: _muted)),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.search_rounded),
          color: Colors.black87,
          onPressed: () {},
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
          child: CircleAvatar(
            radius: 16,
            backgroundColor: _cardBg,
            child: Icon(Icons.person, color: Colors.grey.shade700, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPills(TextTheme textTheme) {
    final pills = ['All Videos', 'Mindfulness', 'Stress Relief', 'Sleep'];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: pills.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == 0;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? _primary : Colors.white,
              border: Border.all(color: selected ? _primary : Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              pills[index],
              style: textTheme.bodyMedium?.copyWith(
                color: selected ? Colors.white : _muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: textTheme.bodyMedium?.copyWith(
              color: _primary,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildFeaturedCard(BuildContext context, TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.white.withOpacity(0.7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/Home page.jpg',
              height: 260,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        'Guided Meditation • 12 mins',
                        style: textTheme.bodySmall?.copyWith(color: _muted, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Morning Clarity with Rahul',
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {
                      Navigator.push(
                      context,
                        MaterialPageRoute(
                          builder: (_) => MeditationDetailPage(
                            title: 'Morning Clarity with Rahul',
                            subtitle: 'Guided Meditation • 12 mins',
                            tag: 'Calm',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                    label: Text(
                      'Start Session',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
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

  Widget _buildRecentList(TextTheme textTheme) {
    final items = [
      {
        'title': 'Anxiety Release',
        'author': 'Sarah Jenkins',
        'duration': '15 min',
        'tag': 'MIND',
      },
      {
        'title': 'Digital Detox',
        'author': 'Dr. Emily Chen',
        'duration': '18 min',
        'tag': 'FOCUS',
      },
      {
        'title': 'Evening Calm',
        'author': 'Priya Sharma',
        'duration': '18 min',
        'tag': 'SLEEP',
      },
    ];

    return Column(
      children: [
        for (final item in items) ...[
          _RecentCard(
            title: item['title']!,
            author: item['author']!,
            duration: item['duration']!,
            tag: item['tag']!,
            accent: _primary,
            muted: _muted,
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _buildInstructors() {
    final instructors = [
      'Sarah J.',
      'Rahul V.',
      'Alex K.',
      'Emily G.',
      'Nina P.',
      'Karan S.',
      'Meera L.',
      'Omar T.',
      'Lina D.',
    ];
    return SizedBox(
      height: 90,
      child: ListView.separated(
        padding: const EdgeInsets.only(right: 8),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: instructors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Home page.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                instructors[index],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSeriesCards(TextTheme textTheme) {
    final series = [
      {
        'title': '7 Days of Mindfulness',
        'subtitle': 'Unlock inner peace in just a week',
      },
      {
        'title': 'Sleep Better Program',
        'subtitle': '14 days of deep rest techniques',
      },
      {
        'title': 'Stress Reset',
        'subtitle': 'Daily tools to unwind and reset',
      },
      {
        'title': 'Focus & Flow',
        'subtitle': 'Sharpen concentration in 10 minutes',
      },
      {
        'title': 'Heartfulness Journey',
        'subtitle': 'Cultivate gratitude and compassion',
      },
      {
        'title': 'Calm Commute',
        'subtitle': 'Arrive refreshed and centered',
      },
      {
        'title': 'Mindful Evenings',
        'subtitle': 'Unwind and prepare for deep rest',
      },
      {
        'title': 'Anxiety Relief Lab',
        'subtitle': 'Practical drills to ease worry',
      },
      {
        'title': 'Morning Clarity',
        'subtitle': 'Start the day with clear intent',
      },
    ];

    return Column(
      children: [
        for (final item in series) ...[
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/Home page.jpg',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.15)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['subtitle']!,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuickCalm(TextTheme textTheme) {
    final quick = [
      {
        'title': 'Breathe',
        'subtitle': 'Instant anxiety relief',
        'icon': Icons.air,
      },
      {
        'title': 'Recharge',
        'subtitle': 'Boost your energy',
        'icon': Icons.bolt,
      },
      {
        'title': 'Grounding',
        'subtitle': 'Come back to center',
        'icon': Icons.spa,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Calm',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            Text(
              '5 Min Sessions',
              style: textTheme.bodyMedium?.copyWith(color: _muted),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: quick
              .map(
                (q) => _QuickCard(
                  title: q['title'] as String,
                  subtitle: q['subtitle'] as String,
                  icon: q['icon'] as IconData,
                  primary: _primary,
                  muted: _muted,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _RecentCard extends StatelessWidget {
  final String title;
  final String author;
  final String duration;
  final String tag;
  final Color accent;
  final Color muted;

  const _RecentCard({
    required this.title,
    required this.author,
    required this.duration,
    required this.tag,
    required this.accent,
    required this.muted,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(14),
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
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              image: const DecorationImage(
                image: AssetImage('assets/images/Home page.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$author • $duration',
                  style: textTheme.bodySmall?.copyWith(color: muted),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: textTheme.labelSmall?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.play_circle_fill, color: accent, size: 28),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color primary;
  final Color muted;

  const _QuickCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.primary,
    required this.muted,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 165,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primary),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: textTheme.bodySmall?.copyWith(color: muted),
          ),
        ],
      ),
    );
  }
}
