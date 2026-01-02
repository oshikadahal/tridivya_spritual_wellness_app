import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Mindful Moments",
          style: TextStyle(color: Colors.black, fontFamily: 'OpenSans Bold'),
        ),
        actions: const [
          Icon(Icons.settings, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome, Anya!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans Bold',
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: _sessionCard(
                      title: "Yoga for Beginners",
                      subtitle: "Start your yoga journey",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _sessionCard(
                      title: "Mindful Meditation",
                      subtitle: "Find your inner peace",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Quick Access",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans Bold',
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _quickAccessCard(
                      icon: Icons.self_improvement,
                      label: "Yoga",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _quickAccessCard(
                      icon: Icons.spa,
                      label: "Meditation",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 22,
                child: _quickAccessCard(
                  icon: Icons.music_note,
                  label: "Mantras",
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Daily Inspiration",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans Bold',
                ),
              ),

              const SizedBox(height: 12),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Embrace the present moment.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans Bold',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Find peace in the here and now.",
                        style: TextStyle(color: Colors.grey, fontFamily: 'OpenSans Regular'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Embrace the present moment.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans Bold',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Find peace in the here and now.",
                        style: TextStyle(color: Colors.grey, fontFamily: 'OpenSans Regular'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Embrace the present moment.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'OpenSans Bold',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Find peace in the here and now.",
                        style: TextStyle(color: Colors.grey, fontFamily: 'OpenSans Regular'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sessionCard({required String title, required String subtitle}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.favorite_border, size: 32),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'OpenSans Bold',
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontFamily: 'OpenSans Regular'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickAccessCard({required IconData icon, required String label}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'OpenSans Regular'),
            ),
          ],
        ),
      ),
    );
  }
}
