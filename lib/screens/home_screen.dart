import 'package:flutter/material.dart';
import 'video_player_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),

                // Title
                Center(
                  child: Text(
                    "Mindful Moments",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                SizedBox(height: 25),

                // Welcome Message
                Text(
                  "Welcome, Anya!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                // Horizontal Scroll Videos
                SizedBox(
                  height: 190,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      videoCard(
                        context,
                        title: "Yoga for Beginners",
                        subtitle: "Start your yoga journey",
                        thumb: "https://picsum.photos/300/200?random=1",
                        videoUrl: "assets/videos/yoga.mp4",
                      ),
                      SizedBox(width: 16),
                      videoCard(
                        context,
                        title: "Mindful Meditation",
                        subtitle: "Find your inner peace",
                        thumb: "https://picsum.photos/300/200?random=2",
                        videoUrl: "assets/videos/meditation.mp4",
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                // Quick Access Title
                Text(
                  "Quick Access",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15),

                // Quick Access Buttons
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    quickButton(Icons.self_improvement, "Yoga"),
                    quickButton(Icons.spa, "Meditation"),
                    quickButton(Icons.music_note, "Mantras"),
                  ],
                ),

                SizedBox(height: 30),

                // Daily Inspiration (Vertical List)
                Text(
                  "Daily Inspiration",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                // Inspiration List
                Column(
                  children: List.generate(
                    6,
                    (index) => inspirationCard(),
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.self_improvement), label: "Sessions"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Progress"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  // Video Card Widget
  Widget videoCard(BuildContext context,
      {required String title,
      required String subtitle,
      required String thumb,
      required String videoUrl}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => VideoPlayerPage(videoUrl: videoUrl)),
        );
      },
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                thumb,
                height: 120,
                width: 260,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Quick Access Buttons
  Widget quickButton(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 8),
          Text(text, style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  // Inspiration Card (Vertical List)
  Widget inspirationCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Embrace the present moment.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Find peace in the here and now.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://picsum.photos/200/140?random=10",
              width: 100,
              height: 80,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
