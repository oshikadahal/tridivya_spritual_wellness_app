import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/features/dashboard/presentation/pages/profile_page.dart';

class MantraScreen extends StatelessWidget {
  const MantraScreen({super.key});

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
              _buildFilterChips(textTheme),
              const SizedBox(height: 16),
              _buildMantraOfDay(textTheme),
              const SizedBox(height: 22),
              _buildSectionTitle('Explore by Intent', textTheme),
              const SizedBox(height: 12),
              _buildIntents(textTheme),
              const SizedBox(height: 22),
              _buildSectionHeader('Popular Mantras', textTheme: textTheme, trailing: 'See All'),
              const SizedBox(height: 12),
              _buildPopularList(textTheme),
              const SizedBox(height: 22),
              _buildSectionTitle('Mantra Playlists', textTheme),
              const SizedBox(height: 12),
              _buildPlaylists(textTheme),
              const SizedBox(height: 22),
              _buildSectionTitle('Learn the Meaning', textTheme),
              const SizedBox(height: 12),
              _buildMeaningCards(textTheme),
              const SizedBox(height: 24),
              _buildNowPlaying(textTheme),
              const SizedBox(height: 16),
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
            Text('Tridivya', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.black)),
            Text('Mantra Library', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: _muted)),
          ],
        ),
        const Spacer(),
        IconButton(icon: const Icon(Icons.search_rounded), color: Colors.black87, onPressed: () {}),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
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

  Widget _buildFilterChips(TextTheme textTheme) {
    final chips = ['All', 'Peace', 'Health', 'Abundance'];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
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
              chips[index],
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

  Widget _buildMantraOfDay(TextTheme textTheme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [_primary, _secondary], begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [BoxShadow(color: _primary.withOpacity(0.25), blurRadius: 16, offset: const Offset(0, 10))],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/Home page.jpg', height: 220, width: double.infinity, fit: BoxFit.cover),
          ),
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.black.withOpacity(0.25)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
                  child: Text('MANTRA OF THE DAY', style: textTheme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 0.6)),
                ),
                const SizedBox(height: 14),
                Text('Lokah Samastah Sukhino\nBhavantu',
                  style: textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Text(
                  '“May all beings everywhere be happy and free, and may my thoughts, words, and actions of my own life contribute in some way to that happiness and to that freedom for all.”',
                  style: textTheme.bodySmall?.copyWith(color: Colors.white.withOpacity(0.9), height: 1.4),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: 170,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.play_circle_filled, size: 20),
                    label: Text('Listen & Chant', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme) {
    return Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: Colors.black));
  }

  Widget _buildSectionHeader(String title, {required TextTheme textTheme, String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: Colors.black)),
        if (trailing != null)
          Text(trailing, style: textTheme.bodyMedium?.copyWith(color: _primary, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _buildIntents(TextTheme textTheme) {
    final intents = [
      {'label': 'Stress Relief', 'color': const Color(0xFFFDE2E4), 'icon': Icons.favorite_border},
      {'label': 'Better Sleep', 'color': const Color(0xFFE4E7FD), 'icon': Icons.nightlight_round},
      {'label': 'Inner Peace', 'color': const Color(0xFFDFF5E3), 'icon': Icons.self_improvement},
      {'label': 'Energy Boost', 'color': const Color(0xFFFDE8D8), 'icon': Icons.bolt},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: intents
          .map(
            (i) => Column(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: i['color'] as Color,
                  child: Icon(i['icon'] as IconData, color: _primary),
                ),
                const SizedBox(height: 6),
                Text(i['label'] as String, style: textTheme.bodySmall?.copyWith(color: _muted)),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildPopularList(TextTheme textTheme) {
    final items = [
      {'title': 'Gayatri Mantra', 'subtitle': 'Universal prayer for spiritual...', 'icon': Icons.play_circle_fill},
      {'title': 'Maha Mrityunjaya', 'subtitle': 'A powerful healing mantra for...', 'icon': Icons.play_circle_fill},
      {'title': 'Om Mani Padme Hum', 'subtitle': 'The jewel in the lotus, mantra of...', 'icon': Icons.play_circle_fill},
    ];

    return Column(
      children: items
          .map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 8))],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _chipBg,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(image: AssetImage('assets/images/Home page.jpg'), fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['title'] as String, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, color: Colors.black)),
                        const SizedBox(height: 4),
                        Text(item['subtitle'] as String, style: textTheme.bodySmall?.copyWith(color: _muted)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(item['icon'] as IconData, color: _primary),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPlaylists(TextTheme textTheme) {
    final playlists = [
      {'title': 'Morning Chants', 'subtitle': '12 Mantras • 45 min'},
      {'title': 'Bedtime Peace', 'subtitle': '8 Mantras • 30 min'},
    ];

    return Row(
      children: playlists
          .map(
            (p) => Expanded(
              child: Container(
                margin: EdgeInsets.only(right: p == playlists.last ? 0 : 12),
                height: 150,
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
                      child: Image.asset('assets/images/Home page.jpg', height: 95, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p['title'] as String, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, color: Colors.black)),
                          const SizedBox(height: 4),
                          Text(p['subtitle'] as String, style: textTheme.bodySmall?.copyWith(color: _muted)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMeaningCards(TextTheme textTheme) {
    final cards = [
      {
        'label': 'WISDOM SNIPPET',
        'title': 'The Power of “OM”',
        'body': 'OM is considered the primordial sound of the universe. It represents the three states of consciousness: waking, dreaming, and deep sleep...',
      },
      {
        'label': 'MANTRA SCIENCE',
        'title': 'Sound Vibrations and the Brain',
        'body': 'Neuroscience shows that rhythmic chanting can stimulate the vagus nerve, helping to lower heart rate and reduce cortisol levels...',
      },
    ];

    return Column(
      children: cards
          .map(
            (c) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 8))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(c['label'] as String, style: textTheme.labelSmall?.copyWith(color: _primary, fontWeight: FontWeight.w800)),
                      const Icon(Icons.bookmark_border, color: Colors.grey, size: 18),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(c['title'] as String, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, color: Colors.black)),
                  const SizedBox(height: 8),
                  Text(c['body'] as String, style: textTheme.bodySmall?.copyWith(color: _muted, height: 1.35)),
                  const SizedBox(height: 10),
                  Text('Read full article  →', style: textTheme.bodySmall?.copyWith(color: _primary, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildNowPlaying(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(image: AssetImage('assets/images/Home page.jpg'), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Maha Mrityunjaya Mantra', style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, color: Colors.black)),
                const SizedBox(height: 4),
                Text('Now Playing', style: textTheme.bodySmall?.copyWith(color: _muted)),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, color: Colors.grey)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.play_circle_fill, color: Colors.purple)),
        ],
      ),
    );
  }
}
