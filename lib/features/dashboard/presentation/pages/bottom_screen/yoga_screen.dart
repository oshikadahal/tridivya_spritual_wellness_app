import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/profile_page.dart';

class YogaScreen extends StatelessWidget {
  const YogaScreen({super.key});

  Color get _primary => const Color(0xFF7C4DFF);
  Color get _secondary => const Color(0xFF8B5CF6);
  Color get _muted => const Color(0xFF6E6B7B);
  Color get _chipBg => const Color(0xFFF2EEFF);

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
              _buildHero(textTheme),
              const SizedBox(height: 18),
              _buildFilters(textTheme),
              const SizedBox(height: 18),
              _buildSectionTitle('Jump Back In', dot: true, textTheme: textTheme),
              const SizedBox(height: 12),
              _buildJumpBack(textTheme),
              const SizedBox(height: 22),
              _buildSectionHeader('Beginner Basics', textTheme: textTheme, trailing: 'SEE ALL'),
              const SizedBox(height: 12),
              _buildBeginnerBasics(textTheme),
              const SizedBox(height: 22),
              _buildSectionTitle('Yoga for Every Goal', textTheme: textTheme),
              const SizedBox(height: 12),
              _buildGoalChips(textTheme),
              const SizedBox(height: 22),
              _buildSectionHeader('Trending Classes', textTheme: textTheme, trailing: 'SEE ALL'),
              const SizedBox(height: 12),
              _buildTrending(textTheme),
              const SizedBox(height: 22),
              _buildSectionHeader('Meet our Instructors', textTheme: textTheme, trailing: 'VIEW ALL'),
              const SizedBox(height: 12),
              _buildInstructors(textTheme),
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
            Text('Yoga Studio', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: _muted)),
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
            backgroundColor: _chipBg,
            child: Icon(Icons.person, color: Colors.grey.shade700, size: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildHero(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(colors: [_primary, _secondary], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(color: _primary.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 10)),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.asset(
              'assets/images/Home page.jpg',
              height: 230,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.55), Colors.black.withOpacity(0.2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'TOP PICK',
                    style: textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 0.6),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Hatha Fundamentals',
                  style: textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  'Perfect your alignment and find balance with our master-led foundational series.',
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.9), height: 1.35),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.menu_book_outlined, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text('15 Lessons', style: textTheme.bodySmall?.copyWith(color: Colors.white)),
                    const SizedBox(width: 16),
                    const Icon(Icons.calendar_today, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text('12 Weeks', style: textTheme.bodySmall?.copyWith(color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {},
                    child: Text('Start Now', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(TextTheme textTheme) {
    final pills = ['All', 'Beginner', 'Intermediate', 'Advanced'];
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
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: selected ? _primary : Colors.grey.shade300),
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

  Widget _buildSectionTitle(String title, {bool dot = false, required TextTheme textTheme}) {
    return Row(
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: Colors.black),
        ),
        if (dot) ...[
          const SizedBox(width: 6),
          Container(width: 8, height: 8, decoration: BoxDecoration(color: _primary, shape: BoxShape.circle)),
        ],
      ],
    );
  }

  Widget _buildSectionHeader(String title, {required TextTheme textTheme, String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: Colors.black),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: textTheme.bodyMedium?.copyWith(color: _primary, fontWeight: FontWeight.w700),
          ),
      ],
    );
  }

  Widget _buildJumpBack(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: _chipBg,
              borderRadius: BorderRadius.circular(14),
              image: const DecorationImage(image: AssetImage('assets/images/Home page.jpg'), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Power Vinyasa Flow', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, color: Colors.black)),
                const SizedBox(height: 4),
                Text('Lesson 4 of 12 • 25m left', style: textTheme.bodySmall?.copyWith(color: _muted)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: 0.65,
                    minHeight: 6,
                    backgroundColor: _chipBg,
                    valueColor: AlwaysStoppedAnimation<Color>(_primary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 18,
            backgroundColor: _primary.withOpacity(0.12),
            child: Icon(Icons.play_arrow, color: _primary),
          ),
        ],
      ),
    );
  }

  Widget _buildBeginnerBasics(TextTheme textTheme) {
    final cards = <Map<String, Object>>[
      {'title': 'Morning Sun Salutation', 'tag': '15 MIN', 'progress': 0.65, 'status': '65% COMPLETED'},
      {'title': 'Gentle Balance Flow', 'tag': '10 MIN', 'progress': 0.0, 'status': 'NOT STARTED'},
    ];

    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = cards[index];
          final title = item['title'] as String;
          final tag = item['tag'] as String;
          final progress = item['progress'] as double;
          final status = item['status'] as String;
          return Container(
            width: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 8))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/Home page.jpg', height: 110, width: 190, fit: BoxFit.cover),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Text(tag, style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: _primary)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, color: Colors.black)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progress,
                                minHeight: 5,
                                backgroundColor: _chipBg,
                                valueColor: AlwaysStoppedAnimation<Color>(_primary),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.favorite_border, size: 18, color: _muted),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(status, style: textTheme.bodySmall?.copyWith(color: _muted)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGoalChips(TextTheme textTheme) {
    final goals = [
      {'icon': Icons.spa, 'label': 'Flexibility'},
      {'icon': Icons.fitness_center, 'label': 'Strength'},
      {'icon': Icons.eco, 'label': 'Stress Relief'},
      {'icon': Icons.monitor_weight, 'label': 'Weight Loss'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: goals
          .map(
            (g) => Column(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: _chipBg,
                  child: Icon(g['icon'] as IconData, color: _primary),
                ),
                const SizedBox(height: 6),
                Text(g['label'] as String, style: textTheme.bodySmall?.copyWith(color: _muted)),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildTrending(TextTheme textTheme) {
    final items = [
      {'title': 'Ultimate Core Flow', 'level': 'Intermediate • 35 mins', 'tag': 'POPULAR'},
      {'title': 'Balance & Breath', 'level': 'Beginner • 20 mins', 'tag': 'NEW'},
      {'title': 'Detox Twist Series', 'level': 'All Levels • 22 mins', 'tag': 'HOT'},
      {'title': 'Slow Stretch Restore', 'level': 'Beginner • 18 mins', 'tag': 'CALM'},
      {'title': 'Power Sculpt', 'level': 'Advanced • 30 mins', 'tag': 'TRENDING'},
      {'title': 'Hip Opener Flow', 'level': 'Intermediate • 28 mins', 'tag': 'POPULAR'},
      {'title': 'Desk Break Yoga', 'level': 'All Levels • 12 mins', 'tag': 'NEW'},
      {'title': 'Sunrise Warmup', 'level': 'Beginner • 15 mins', 'tag': 'FRESH'},
    ];

    return Column(
      children: [
        for (final item in items) ...[
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 8))],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/Home page.jpg', width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _chipBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(item['tag'] as String, style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700, color: _primary)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(item['title'] as String, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, color: Colors.black)),
                      const SizedBox(height: 4),
                      Text(item['level'] as String, style: textTheme.bodySmall?.copyWith(color: _muted)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 72,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primary,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    child: Text('Start', style: textTheme.labelLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInstructors(TextTheme textTheme) {
    final instructors = ['Elena Joy', 'Mark Chen', 'Sarah Rose', 'David Lee', 'Nina P.', 'Karan S.', 'Priya M.'];
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: instructors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _chipBg,
                  borderRadius: BorderRadius.circular(14),
                  image: const DecorationImage(image: AssetImage('assets/images/Home page.jpg'), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 70,
                child: Text(
                  instructors[index],
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(color: Colors.black87, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
