import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final cardWidth = isTablet
        ? (screenWidth - 64) / 3
        : (screenWidth - 48) / 2;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // -----------------------------------
          // TOP ROW
          // -----------------------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Mindful Moments",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.notifications_none, size: 30),
            ],
          ),

          const SizedBox(height: 16),

          // -----------------------------------
          // SEARCH BAR
          // -----------------------------------
          TextField(
            decoration: InputDecoration(
              hintText: "Search sessions",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // -----------------------------------
          // TOP CARD
          // -----------------------------------
          basicCard(
            title: "Quote of the Day",
            subtitle: "Peace comes from within",
          ),

          const SizedBox(height: 16),

          // -----------------------------------
          // FOR YOU
          // -----------------------------------
          const Text(
            "For You",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          basicCard(
            title: "Recommended Session",
            subtitle: "Mindful meditation",
          ),

          const SizedBox(height: 16),

          // -----------------------------------
          // CATEGORIES
          // -----------------------------------
          const Text(
            "Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              4,
              (index) => SizedBox(
                width: cardWidth,
                child: basicCard(
                  title: "Meditation",
                  subtitle: "Relax & focus",
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // -----------------------------------
          // DAILY INSPIRATION
          // -----------------------------------
          const Text(
            "Daily Inspiration",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              4,
              (index) => SizedBox(
                width: cardWidth,
                child: basicCard(
                  title: "Be Present",
                  subtitle: "Mindfulness tip",
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

 
  static Widget basicCard({
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
