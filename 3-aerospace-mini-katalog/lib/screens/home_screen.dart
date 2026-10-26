import 'package:flutter/material.dart';
import '../models/planet.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Planet> planets = [
    Planet(
      name: "Mars",
      description: "Kızıl gezegen olarak bilinen, demir oksit zengini dördüncü gezegen.",
      image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/OSIRIS_Mars_true_color.jpg/600px-OSIRIS_Mars_true_color.jpg",
      gravity: "3.721 m/s²",
      temperature: "-63 °C",
      themeColor: Colors.orange,
    ),
    Planet(
      name: "Satürn",
      description: "Halkalarıyla ünlü, Güneş Sistemi'nin en büyük ikinci gezegeni.",
      image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Saturn_during_Equinox.jpg/600px-Saturn_during_Equinox.jpg",
      gravity: "10.44 m/s²",
      temperature: "-178 °C",
      themeColor: Colors.amber,
    ),
    Planet(
      name: "Jüpiter",
      description: "Güneş Sistemi'nin en büyük devasa gaz gezegeni.",
      image: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e2/Jupiter.jpg/600px-Jupiter.jpg",
      gravity: "24.79 m/s²",
      temperature: "-108 °C",
      themeColor: Colors.brown,
    ),
    Planet(
      name: "Venüs",
      description: "Güneş Sistemi'nin en sıcak ve parlak gezegeni.",
      image: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b2/Venus_2_Approach_Image.jpg/600px-Venus_2_Approach_Image.jpg",
      gravity: "8.87 m/s²",
      temperature: "462 °C",
      themeColor: Colors.yellow,
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0D17),
      appBar: AppBar(
        title: const Text("AERO SPACE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white10,
                  child: Icon(Icons.rocket_launch, color: Colors.deepOrange, size: 35),
                ),
                SizedBox(height: 20),
                Text("Hoş Geldin Nevin,", style: TextStyle(color: Colors.white54, fontSize: 18)),
                SizedBox(height: 10),
                Text(
                  "Evreni Keşfetmeye\nHemen Başla",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Center(
            child: Text("GEZEGEN KATALOĞU", style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
          ),
          const SizedBox(height: 25),
          for (var planet in planets)
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailScreen(planet: planet)),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(planet.image, height: 70, width: 70, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(planet.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(planet.gravity, style: const TextStyle(color: Colors.white38, fontSize: 14)),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}