import 'package:flutter/material.dart';
import 'video_player_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // -----------------------------------------------------
              // HEADER SECTION
              // -----------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mindful Moments",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Welcome 👋",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

         
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple.shade100, Colors.blue.shade100],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Quote of the Day",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "“Peace comes from within. Do not seek it without.”",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 25),


              sectionTitle("Recommended Sessions"),

              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    sessionCard(
                      context: context,
                      title: "Yoga for Beginners",
                      duration: "10 min",
                      thumbnail: "assets/thumbnails/yogathumbnail.jpg",
                      videoUrl: "assets/videos/meditation1.mp4",
                    ),
                    sessionCard(
                      context: context,
                      title: "Mindful Meditation",
                      duration: "12 min",
                      thumbnail: "assets/thumbnails/breathing1.webp",
                      videoUrl: "assets/videos/meditation1.mp4",
                    ),
                    sessionCard(
                      context: context,
                      title: "Deep Breathing",
                      duration: "8 min",
                      thumbnail: "assets/thumbnails/thumbnail1.jpg",
                      videoUrl: "assets/videos/meditation1.mp4",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 25),

             
              sectionTitle("Categories"),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    categoryButton(Icons.self_improvement, "Yoga"),
                    categoryButton(Icons.spa, "Meditation"),
                    categoryButton(Icons.music_note, "Mantras"),
                    categoryButton(Icons.bedtime, "Sleep"),
                    categoryButton(Icons.favorite, "Self-care"),
                    categoryButton(Icons.nature_people, "Breathing"),
                  ],
                ),
              ),

              SizedBox(height: 30),

         
              sectionTitle("Daily Inspiration"),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    inspirationCard(
                      title: "Embrace the present moment.",
                      subtitle: "Find peace in the here and now.",
                      image: "assets/thumbnails/thumbnail1.jpg",
                    ),
                    inspirationCard(
                      title: "Breathe deeply and let go.",
                      subtitle: "Release what no longer serves you.",
                      image: "assets/thumbnails/thumbnail2.jpg",
                    ),
                    inspirationCard(
                      title: "Find stillness within.",
                      subtitle: "Quiet your mind, hear your soul.",
                      image: "assets/thumbnails/thumbnail3.jpg",
                    ),
                    inspirationCard(
                      title: "Balance your mind and body.",
                      subtitle: "Harmony starts from within.",
                      image: "assets/thumbnails/thumbnail1.jpg",
                    ),
                    inspirationCard(
                      title: "Journey inward with intention.",
                      subtitle: "Every breath brings you closer to peace.",
                      image: "assets/thumbnails/thumbnail2.jpg",
                    ),
                    inspirationCard(
                      title: "Transform through practice.",
                      subtitle: "Consistency creates change.",
                      image: "assets/thumbnails/thumbnail3.jpg",
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: kBottomNavigationBarHeight + MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.self_improvement), label: "Sessions"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }


  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget sessionCard({
    required BuildContext context,
    required String title,
    required String duration,
    required String thumbnail,
    required String videoUrl,
  }) {
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
        height: 210,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 8, spreadRadius: 2, color: Colors.black12),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              child: (thumbnail.startsWith('http') || thumbnail.startsWith('https'))
                ? Image.network(thumbnail, height: 120, width: 260, fit: BoxFit.cover)
                : Image.asset(thumbnail, height: 120, width: 260, fit: BoxFit.cover)),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(duration, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryButton(IconData icon, String title) {
    return Container(
      width: 105,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 26, color: Colors.black),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget inspirationCard({
    required String title,
    required String subtitle,
    required String image,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 18),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text(subtitle,
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(image,
                  width: 90, height: 70, fit: BoxFit.cover)),
        ],
      ),
    );
  }
}
