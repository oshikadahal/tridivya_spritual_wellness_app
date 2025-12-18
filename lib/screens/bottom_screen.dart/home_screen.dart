import 'package:flutter/material.dart';
import 'package:tridivya_spritual_wellness_app/widgets/home_card.dart';
import 'package:tridivya_spritual_wellness_app/widgets/search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // top title bar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Mindful Moments', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings_outlined),
              )
            ],
          ),
          const SizedBox(height: 12),

          // welcome text
          const Text('Welcome, Anya!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),

          // search
          const SearchField(hintText: 'Search sessions'),
          const SizedBox(height: 12),

          // two cards row (no images)
          Row(
            children: [
              Expanded(
                child: HomeCard(
                  title: 'Yoga for Beginners',
                  subtitle: 'Start your yoga journey',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: HomeCard(
                  title: 'Mindful Meditation',
                  subtitle: 'Find your inner peace',
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

        
          const Text('Quick Access', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),

   
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              quickAccessButton(icon: Icons.self_improvement, label: 'Yoga'),
              quickAccessButton(icon: Icons.self_improvement_outlined, label: 'Meditation'),
              quickAccessButton(icon: Icons.music_note, label: 'Mantras'),
            ],
          ),

          const SizedBox(height: 18),

          // Daily Inspiration
          const Text('Daily Inspiration', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Embrace the present.', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('Find peace in the here and now.'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget quickAccessButton({required IconData icon, required String label}) {
    return SizedBox(
      width: 140,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 20),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

